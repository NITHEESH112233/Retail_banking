async function fetchCurrentUser() {
    try {
        const response = await fetch('/api/current_user');
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
        const response = await fetch('/api/logout', { method: 'POST' });
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
    // A simple alert for now, could be enhanced to a toast
    alert(message);
}
