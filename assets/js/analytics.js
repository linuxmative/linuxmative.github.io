(async () => {
  const event = {
    timestamp: new Date().toISOString(),
    path: window.location.pathname,
    referrer: document.referrer || null,
    userAgent: navigator.userAgent,
  };

  await fetch("https://api.github.com/repos/linuxmative/linuxmative.github.io/dispatches", {
    method: "POST",
    headers: {
      "Accept": "application/vnd.github.everest-preview+json",
      "Authorization": "Bearer GH_TOKEN_PLACEHOLDER"
    },
    body: JSON.stringify({
      event_type: "page_view",
      client_payload: event
    })
  });
})();
