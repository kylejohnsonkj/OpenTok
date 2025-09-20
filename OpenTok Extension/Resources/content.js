// The primary DOM object for the TikTok web experience
const appNode = document.getElementById("app");

// Check if the URL is for a TikTok video or photo slideshow (or still a short form URL)
if (window.location.hostname === 'www.tiktok.com' &&
    (/^\/@[^/]*\/(video|photo)\/\d+/.test(window.location.pathname) || /^\/t\//.test(window.location.pathname))) {
    
    // Check for query parameters (which prevent video playback)
    if (window.location.search) {
        // Construct a new URL without query parameters
        const newUrl = window.location.origin + window.location.pathname;
        
        // Redirect to the new URL
        window.location.replace(newUrl);
    }
    
    // In case the short form URL resolves late, retry the redirect after 3 seconds
    setTimeout(() => {
        if (window.location.search) {
            const newUrl = window.location.origin + window.location.pathname;
            window.location.replace(newUrl);
        }
    }, 3000);
    
    const observer = new MutationObserver(() => {
        // Remove smart app banner and automatically close dialog boxes
        document.querySelector('meta[name="apple-itunes-app"]')?.remove();
        document.querySelector('button[class*="close-button"]')?.click();
        document.querySelector('span[data-e2e*="launch-popup-close"]')?.click();
        
        // Attempt to insert casual review prompt
        insertMessageUnderWatchAgain();
        
        // Relocate comments under the video
        relocateComments();
    });
    
    observer.observe(appNode, {
      childList: true,
      attributes: true,
      characterData: true,
      subtree: true
    });
    
    // Force the "Watch again" button to restart the video
    // when tapped more than once (instead of redirecting to the App Store)
    let didWatchAgain = false;
    document.addEventListener("click", function(event) {
        if (event.target && event.target.closest('div[class*="DivCTABtnContainer"]')) {
            if (didWatchAgain) {
                event.stopPropagation();
                window.location.reload();
            } else {
                didWatchAgain = true;
            }
        }
    }, true);
    
} else if (window.location.hostname === 'www.tiktok.com' && /^\/discover\//.test(window.location.pathname)) {
    const observer = new MutationObserver(() => {
        const link = document.querySelector('div[class*="DivVideoCard"][style*="grid-column"] div[class*="DivVideoPlayer"] a');
        if (link) {
            window.location.replace(link.href);
            observer.disconnect();
        }
    });
    
    observer.observe(appNode, {
        childList: true,
        attributes: true,
        characterData: true,
        subtree: true
    });
}

function relocateComments() {
    const commentsId = "relocated-comments";
    
    if (document.getElementById(commentsId)) return;
    
    // Open the comments modal
    document.querySelector('div[data-e2e="play-side-comment"]')?.click();
    
    const observer = new MutationObserver(() => {
        const layoutBox = document.querySelector('div[class*="layout-box"]');
        const commentsHeader = document.querySelector('div[class*="DivHeaderWrapper"]');
        const comments = document.querySelector('div[class*="DivCommentListContainer"]');
        
        // Wait until actual comments are loaded (not skeletons)
        const hasRealComments = comments?.querySelector('div[class*="DivCommentItemContainer"]');
        
        if (layoutBox && commentsHeader && comments && hasRealComments) {
            if (!document.getElementById(commentsId)) {
                // Relocate the comments below the video
                commentsHeader.id = commentsId;
                layoutBox.appendChild(commentsHeader);
                layoutBox.appendChild(comments);
            }
            document.querySelector('div[class*="DivCloseWrapper"]')?.click();
            observer.disconnect();
        }
    });
    
    observer.observe(appNode, {
        childList: true,
        attributes: true,
        characterData: true,
        subtree: true
    });
}

function insertMessageUnderWatchAgain() {
    // Exclude from setup video
    const setupVideoId = "/video/6876424179084709126";
    if (window.location.pathname.includes(setupVideoId)) return;
    
    // Exclude if user has already reviewed the current version
    const currentVersion = chrome.runtime.getManifest().version;
    if (currentVersion === localStorage.getItem("OpenTok-lastReviewedVersion")) return;
    
    // Do not reinsert if message is already present
    const messageId = "opentok-message";
    if (document.getElementById(messageId)) return;
    
    // Do not insert if 'Watch again' container cannot be found
    const targetElement = document.querySelector('div[class*="DivSwiperList"]');
    if (!targetElement) return;
    
    const message = createMessageElement(messageId);
    targetElement.appendChild(message);
}

function createMessageElement(messageId) {
    const message = document.createElement("div");
    message.id = messageId;
    
    Object.assign(message.style, {
        width: "100%",
        textAlign: "center",
        padding: "25px",
        fontSize: "13px",
        fontFamily: "Arial, Tahoma, sans-serif",
        position: "absolute",
        bottom: "0",
        left: "0"
    });
    
    const link = createReviewLink();
    message.appendChild(link);
    return message;
}

function createReviewLink() {
    const link = document.createElement("a");
    link.href = "opentok://review";
    Object.assign(link.style, { color: "white", textDecoration: "none" });
    
    const plainText = document.createElement("span");
    const underlinedText = document.createElement("span");
    underlinedText.style.textDecoration = "underline";
    
    plainText.textContent = "Enjoying OpenTok?";
    underlinedText.textContent = "Help spread the word!";
    link.append(plainText, " ", underlinedText);
    
    link.addEventListener("click", () => {
        localStorage.setItem("OpenTok-lastReviewedVersion", chrome.runtime.getManifest().version);
        plainText.textContent = "Thank you! ❤️";
        underlinedText.textContent = "";
    });
    
    return link;
}
