// ==UserScript==
// @name         Jira Skillbox Enhancements
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Remove clutter and add copy buttons for Jira Skillbox
// @match        https://jira.skillbox.pro/browse/*
// @grant        none
// @run-at       document-start
// ==/UserScript==

(function () {
  "use strict";

  // Hide content immediately to prevent flickering
  const style = document.createElement("style");
  style.id = "jira-enhance-hide";
  style.textContent = `
        .issue-main-column #details-module {
            display: none !important;
        }
        #rowForcustomfield_16337,
        #collaboratorsmodule,
        #greenhopper-agile-issue-web-panel,
        #panel-testcases-right,
        #panel-launches-right,
        #tempo-issue-view-panel,
        #isjp-issue-section {
            display: none !important;
        }
    `;
  document.documentElement.appendChild(style);

  const ELEMENTS_TO_REMOVE = [
    "#rowForcustomfield_16337",
    "#collaboratorsmodule",
    "#greenhopper-agile-issue-web-panel",
    "#panel-testcases-right",
    "#panel-launches-right",
    "#tempo-issue-view-panel",
    "#isjp-issue-section",
  ];

  function removeElements() {
    ELEMENTS_TO_REMOVE.forEach((selector) => {
      const el = document.querySelector(selector);
      if (el) el.remove();
    });
  }

  function moveDetailsToSidebar() {
    const detailsModule = document.querySelector("#details-module");
    const peopleModule = document.querySelector("#peoplemodule");

    if (detailsModule && peopleModule && !detailsModule.dataset.moved) {
      peopleModule.after(detailsModule);
      detailsModule.dataset.moved = "true";
    }

    const issueDetails = document.querySelector("#issuedetails");
    if (issueDetails) {
      issueDetails.classList.remove("two-cols");
    }
  }

  function getIssueKey() {
    const match = window.location.pathname.match(/\/browse\/([A-Z]+-\d+)/);
    return match ? match[1] : null;
  }

  function getSummary() {
    const summaryEl = document.querySelector("#summary-val");
    if (!summaryEl) return null;
    const clone = summaryEl.cloneNode(true);
    const icon = clone.querySelector(".overlay-icon");
    if (icon) icon.remove();
    return clone.textContent.trim();
  }

  function copyToClipboard(text) {
    navigator.clipboard.writeText(text);
  }

  function copyKey() {
    const key = getIssueKey();
    if (key) {
      copyToClipboard(key);
      showNotification(`Copied: ${key}`);
    }
  }

  function copyMarkdown() {
    const key = getIssueKey();
    const summary = getSummary();
    if (key && summary) {
      const md = `[${key}: ${summary}](https://jira.skillbox.pro/browse/${key})`;
      copyToClipboard(md);
      showNotification("Copied markdown link");
    }
  }

  function showNotification(message) {
    const notification = document.createElement("div");
    notification.textContent = message;
    notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: #0052cc;
            color: white;
            padding: 12px 20px;
            border-radius: 4px;
            z-index: 10000;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
        `;
    document.body.appendChild(notification);
    setTimeout(() => notification.remove(), 2000);
  }

  function createButton(text, onClick) {
    const btn = document.createElement("button");
    btn.textContent = text;
    btn.style.cssText = `
            margin-left: 8px;
            padding: 4px 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
            background: #f4f5f7;
            cursor: pointer;
            font-size: 14px;
            vertical-align: middle;
        `;
    btn.addEventListener("click", onClick);
    btn.addEventListener(
      "mouseenter",
      () => (btn.style.background = "#e4e5e7"),
    );
    btn.addEventListener(
      "mouseleave",
      () => (btn.style.background = "#f4f5f7"),
    );
    return btn;
  }

  function addCopyButtons() {
    const summaryEl = document.querySelector("#summary-val");
    if (!summaryEl || document.querySelector("#jira-copy-key-btn")) return;

    const keyBtn = createButton("🔑", copyKey);
    keyBtn.id = "jira-copy-key-btn";
    keyBtn.title = "Copy issue key (i)";

    const mdBtn = createButton("📋", copyMarkdown);
    mdBtn.id = "jira-copy-md-btn";
    mdBtn.title = "Copy markdown link (m)";

    summaryEl.parentNode.insertBefore(mdBtn, summaryEl.nextSibling);
    summaryEl.parentNode.insertBefore(keyBtn, summaryEl.nextSibling);
  }

  let lastKey = "";
  let lastKeyTime = 0;

  function openLinkDialog() {
    // Try to find the Link menu item directly
    let linkItem = document.querySelector('a[href*="LinkJiraIssue"]');
    if (linkItem) {
      linkItem.click();
      showNotification("Opening link dialog...");
      return;
    }

    // If not found, open the More dropdown first
    const moreButton = document.querySelector("#opsbar-operations_more");
    if (moreButton) {
      moreButton.click();
      setTimeout(() => {
        linkItem = document.querySelector('a[href*="LinkJiraIssue"]');
        if (linkItem) {
          linkItem.click();
          showNotification("Opening link dialog...");
        }
      }, 100);
    }
  }

  function openLabelsDialog() {
    // Try to find the Labels menu item directly
    let labelsItem = document.querySelector('a[href*="EditLabels"]');
    if (labelsItem) {
      labelsItem.click();
      showNotification("Opening labels dialog...");
      return;
    }

    // If not found, open the More dropdown first
    const moreButton = document.querySelector("#opsbar-operations_more");
    if (moreButton) {
      moreButton.click();
      setTimeout(() => {
        labelsItem = document.querySelector('a[href*="EditLabels"]');
        if (labelsItem) {
          labelsItem.click();
          showNotification("Opening labels dialog...");
        }
      }, 100);
    }
  }

  function handleKeyPress(e) {
    if (
      e.target.tagName === "INPUT" ||
      e.target.tagName === "TEXTAREA" ||
      e.target.isContentEditable
    ) {
      return;
    }

    const now = Date.now();
    const key = e.key;
    const timeDiff = now - lastKeyTime;

    // Check for two-key sequences starting with l/д
    if ((lastKey === "l" || lastKey === "д") && timeDiff < 400) {
      // ll or дд -> Link dialog
      if (key === "l" || key === "д") {
        e.preventDefault();
        openLinkDialog();
        lastKey = "";
        lastKeyTime = 0;
        return;
      }
      // lb or ди -> Labels dialog
      if (key === "b" || key === "и") {
        e.preventDefault();
        openLabelsDialog();
        lastKey = "";
        lastKeyTime = 0;
        return;
      }
    }

    // Update last key tracking for sequence starters
    if (key === "l" || key === "д") {
      lastKey = key;
      lastKeyTime = now;
      return;
    }

    lastKey = "";
    lastKeyTime = 0;

    if (e.key === "i" || e.key === "ш") {
      e.preventDefault();
      copyKey();
    } else if (e.key === "m" || e.key === "ь") {
      e.preventDefault();
      copyMarkdown();
    }
  }

  function showContent() {
    // No longer needed - CSS selector only hides details in main column
  }

  function applyModifications() {
    removeElements();
    moveDetailsToSidebar();
    addCopyButtons();
  }

  function init() {
    applyModifications();
    showContent();

    const observer = new MutationObserver(() => {
      applyModifications();
    });

    observer.observe(document.body, {
      childList: true,
      subtree: true,
    });

    document.addEventListener("keydown", handleKeyPress);
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", init);
  } else {
    init();
  }
})();
