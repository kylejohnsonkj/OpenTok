// Get the current URL
const url = new URL(window.location.href);

// Check if the URL is for a TikTok video or photo slideshow
if (url.hostname === 'www.tiktok.com' && /^\/@[^/]*\/(video|photo)\/\d+/.test(url.pathname)) {
    // Check for query parameters (which prevent video playback)
    if (url.search) {
        // Construct a new URL without query parameters
        const newUrl = `${url.origin}${url.pathname}`;
        
        // Redirect to the new URL
        window.location.replace(newUrl);
    }
    
    document.addEventListener('DOMSubtreeModified', () => {
        // Remove smart app banner and automatically close dialog boxes
        document.querySelector('meta[name="apple-itunes-app"]')?.remove();
        document.querySelector('button[class*="close-button"]')?.click();
        document.querySelector('span[data-e2e*="launch-popup-close"]')?.click();
        
        // Attempt to insert casual review prompt
        insertMessageUnderWatchAgain();
        
        // Relocate comments back under the video
        relocateComments();
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
    
} else if (url.hostname === 'www.tiktok.com' && /^\/discover\//.test(url.pathname)) {
    document.addEventListener('DOMSubtreeModified', () => {
        const link = document.querySelector('div[class*="DivVideoCard"][style*="grid-column"] div[class*="DivVideoPlayer"] a');
        if (link) {
            window.location.replace(link.href);
        }
    });
}

function relocateComments() {
    const commentsId = "relocated-comments";
    
    // Tap the comments button to display the modal in the background
    setTimeout(() => {
        if (document.getElementById(commentsId)) return;
        
        document.querySelector('div[data-e2e="play-side-comment"]')?.click();
        
        // After the modal finishes appearing, relocate the comments below the video
        setTimeout(() => {
            if (document.getElementById(commentsId)) return;
            
            const layoutBox = document.querySelector('div[class*="layout-box"]');
            if (!layoutBox) return;
            
            const commentsHeader = document.querySelector('div[class*="DivHeaderWrapper"]');
            if (commentsHeader) {
                commentsHeader.id = commentsId;
                layoutBox.appendChild(commentsHeader);
            }
            
            const comments = document.querySelector('div[class*="DivCommentListContainer"]');
            if (comments) {
                layoutBox.appendChild(comments);
            }
            
            document.querySelector('div[class*="DivCloseWrapper"]')?.click();
        }, 1000);
    }, 750);
}

function insertMessageUnderWatchAgain() {
    // Exclude from setup video
    const setupVideoId = "/video/6876424179084709126";
    if (url.pathname.includes(setupVideoId)) return;
    
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
