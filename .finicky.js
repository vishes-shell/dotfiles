// ~/.finicky.js

export default {
  defaultBrowser: "/Applications/Firefox Developer Edition.app",

  rewrite: [
    {
      match: ({ url }) => url.protocol === "http:",
      url: ({ url }) => ({ ...url, protocol: "https:" }),
    },
  ],

  handlers: [
    {
      match: ["meet.google.com/*", "edu.livedigital.space/*"],
      browser: "Google Chrome",
    },
  ],

  options: {
    hideIcon: true,
  },
};
