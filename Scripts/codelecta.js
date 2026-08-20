document.addEventListener('DOMContentLoaded', () => {
    // 1. Mobile Nav Toggle
    const hamburger = document.querySelector('.nav-hamburger');
    const navMenu = document.querySelector('.nav-menu');

    if (hamburger && navMenu) {
        hamburger.addEventListener('click', () => {
            hamburger.classList.toggle('active');
            navMenu.classList.toggle('active');
        });

        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!hamburger.contains(e.target) && !navMenu.contains(e.target)) {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
            }
        });

        // Close menu when clicking a link
        navMenu.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', () => {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
            });
        });
    }

    // 2. Password Visibility Toggle
    const passwordToggles = document.querySelectorAll('.password-toggle');
    passwordToggles.forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            e.preventDefault();
            const wrapper = this.closest('.password-wrapper');
            if (!wrapper) return;
            
            const input = wrapper.querySelector('input');
            const svg = this.querySelector('svg');
            
            if (input && svg) {
                if (input.type === 'password') {
                    input.type = 'text';
                    this.style.color = 'var(--text-primary)';
                } else {
                    input.type = 'password';
                    this.style.color = 'var(--text-muted)';
                }
            }
        });
    });

    // 3. Active Nav Link
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-links a');
    
    navLinks.forEach(link => {
        const href = link.getAttribute('href');
        if (href) {
            const cleanHref = href.replace(/^~/, '');
            if (currentPath.endsWith(cleanHref) && cleanHref !== '/') {
                link.classList.add('active');
            } else if (currentPath === '/' && cleanHref === '/') {
                link.classList.add('active');
            }
        }
    });

    // 4. Navbar scroll effect
    const navbar = document.querySelector('.codelecta-nav');
    if (navbar) {
        window.addEventListener('scroll', () => {
            if (window.scrollY > 20) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    }

    // 5. Smooth reveal on scroll
    const revealElements = document.querySelectorAll('.reveal');
    if (revealElements.length > 0) {
        if ('IntersectionObserver' in window) {
            const revealObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('revealed');
                        observer.unobserve(entry.target);
                    }
                });
            }, {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            });

            revealElements.forEach(el => {
                revealObserver.observe(el);
            });
        } else {
            // Fallback for browsers without IntersectionObserver
            revealElements.forEach(el => el.classList.add('revealed'));
        }
    }

    // 6. User Profile Dropdown Outside Click Closer
    document.addEventListener('click', (e) => {
        const dropdownWrapper = document.getElementById('userDropdownWrapper');
        if (dropdownWrapper && !dropdownWrapper.contains(e.target)) {
            dropdownWrapper.classList.remove('active');
        }
    });
});

// Global dropdown toggle function for the button onclick
function toggleUserDropdown(e) {
    if (e) {
        e.preventDefault();
        e.stopPropagation();
    }
    const wrapper = document.getElementById('userDropdownWrapper');
    if (wrapper) {
        wrapper.classList.toggle('active');
    }
}

