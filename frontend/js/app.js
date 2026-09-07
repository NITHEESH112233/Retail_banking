// 1. Define your backend URL (Replace this with your actual Railway URL!)
const API_BASE_URL = 'https://retailbanking-production.up.railway.app'; 

async function fetchCurrentUser() {
    try {
        // 2. Use the base URL and add credentials
        const response = await fetch(`${API_BASE_URL}/api/current_user`, {
            method: 'GET',
            credentials: 'include', // CRITICAL: This sends your session cookie to the backend
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            window.location.href = '/index.html';
            return null;
        }
        return await response.json();
    } catch (error) {
        console.error('Error fetching user:', error);
        window.location.href = '/index.html';
        return null;
    }
}

async function handleLogout() {
    try {
        // Update URL and add credentials here too
        const response = await fetch(`${API_BASE_URL}/api/logout`, { 
            method: 'POST',
            credentials: 'include'
        });
        if (response.ok) {
            window.location.href = '/index.html?logout=true';
        }
    } catch (error) {
        console.error('Error during logout:', error);
    }
}

function initNavbar() {
    const logoutBtn = document.getElementById('logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', (e) => {
            e.preventDefault();
            handleLogout();
        });
    }
}

function showNotification(message, isError = false) {
    alert(message);
}

// Add your Railway URL to the fetch call
const response = await fetch('https://retailbanking-production.up.railway.app/api/login', {
    method: 'POST',
    // ... your other headers and body
    credentials: 'include' // Remember this is crucial for sessions!
});