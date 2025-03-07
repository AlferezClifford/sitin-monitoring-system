window.onbeforeunload = function () {
    localStorage.clear();  // Clears local storage
    sessionStorage.clear(); // Clears session storage
    caches.keys().then(names => names.forEach(name => caches.delete(name)));
};
