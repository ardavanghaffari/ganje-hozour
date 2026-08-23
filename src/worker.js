/**
 * @typedef {Object} Env
 * @property {R2Bucket} MEDIA
 * @property {Fetcher} ASSETS
 */

const mediaPrefix = "/media/";

/**
 * @param {Request} request
 * @param {Env} env
 */
async function serveMedia(request, env) {
  if (request.method !== "GET" && request.method !== "HEAD") {
    return new Response("Method Not Allowed", {
      status: 405,
      headers: { Allow: "GET, HEAD" },
    });
  }

  const url = new URL(request.url);
  const key = decodeURIComponent(url.pathname.slice(1));
  if (!key) return new Response("Not Found", { status: 404 });

  const object = await env.MEDIA.get(key, {
    range: request.headers,
  });

  if (object === null) return new Response("Not Found", { status: 404 });

  const headers = new Headers();
  object.writeHttpMetadata(headers);
  headers.set("etag", object.httpEtag);
  headers.set("accept-ranges", "bytes");

  if (object.range) {
    const { offset, length } = object.range;
    headers.set("content-range", `bytes ${offset}-${offset + length - 1}/${object.size}`);
    headers.set("content-length", String(length));
  } else {
    headers.set("content-length", String(object.size));
  }

  return new Response(request.method === "HEAD" ? null : object.body, {
    status: object.range ? 206 : 200,
    headers,
  });
}

export default {
  /**
   *  @param {Request} request
   *  @param {Env} env
   */
  async fetch(request, env) {
    const pathname = new URL(request.url).pathname;
    if (pathname.startsWith(mediaPrefix)) return serveMedia(request, env);

    return env.ASSETS.fetch(request);
  },
};
