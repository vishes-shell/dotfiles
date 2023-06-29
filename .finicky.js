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
    // {
    //   // Open apple.com and example.org urls in Safari
    //   match: ["apple.com/*", "example.org/*"],
    //   browser: "Safari"
    // },
    // {
    //   // Open any url that includes the string "workplace" in Firefox
    //   match: /workplace/,
    //   browser: "Firefox"
    // },
    // {
    //   // Open google.com and *.google.com urls in Google Chrome
    //   match: [
    //     "google.com/*", // match google.com urls
    //     "*.google.com/*", // match google.com subdomains
    //   ],
    //   browser: "Google Chrome"
    // }
  ],
};
