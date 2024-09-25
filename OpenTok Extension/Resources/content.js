// Get the current URL
const url = new URL(window.location.href);

// Check if the URL is for a TikTok video or photo slideshow
if (url.hostname === 'www.tiktok.com' && /^\/@[^/]+\/(video|photo)\/\d+/.test(url.pathname)) {
    // Check for query parameters (which prevent video playback)
    if (url.search) {
        // Construct a new URL without query parameters
        const newUrl = `${url.origin}${url.pathname}`;
        
        // Redirect to the new URL
        window.location.replace(newUrl);
    }
    
    // Remove smart app banner and automatically close dialog boxes
    document.addEventListener('DOMSubtreeModified', () => {
        document.querySelector('meta[name="apple-itunes-app"]')?.remove();
        document.querySelector('button[class*="close-button"]')?.click();
        document.querySelector('span[data-e2e*="launch-popup-close"]')?.click();
    });
    
    // Force the "Watch again" button to restart the video
    // Normal behavior when pressed more than once is to redirect to the App Store
    document.addEventListener("click", function(event) {
        if (event.target.closest('div[class*="DivBtnWrapper"]')) {
            event.stopPropagation();
            window.location.reload();
        }
    }, true);
}
