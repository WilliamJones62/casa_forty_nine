async function copyURLToClipboard() {
    try {
        await navigator.clipboard.writeText(window.location.href);
        console.log('URL copied to clipboard!');
      } catch (err) {
        console.error('Failed to copy URL: ', err);
      }
    alert("Link copied!");
}