// Get the current URL
const url = new URL(window.location.href);

// Check if the hostname is 'www.tiktok.com', the pathname matches the expected pattern, and there are query parameters
if (url.hostname === 'www.tiktok.com' && /^\/@[^/]+\/(video|photo)\/\d+/.test(url.pathname) && url.search) {
    // Construct the new URL without query parameters
    const newUrl = `${url.origin}${url.pathname}`;
    
    // Redirect to the new URL
    window.location.replace(newUrl);
}
