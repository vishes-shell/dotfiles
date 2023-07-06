// ~/.finicky.js

module.exports = {
  defaultBrowser: "/Applications/Firefox Developer Edition.app",
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" },
    },
  ],
  handlers: [
    {
      match: ["meet.google.com/*"],
      browser: "Google Chrome",
    },
  ],
};
