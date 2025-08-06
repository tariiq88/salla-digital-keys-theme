/**
 * Digital Keys Store Theme JavaScript
 * Main functionality for Salla theme
 */

class DigitalKeysTheme {
    constructor() {
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.initializeComponents();
        this.setupSallaIntegration();
    }

    setupEventListeners() {
        // Mobile menu toggle
        this.setupMobileMenu();
        
        // Smooth scrolling
        this.setupSmoothScrolling();
        
        // Product interactions
        this.setupProductInteractions();
        
        // Cart functionality
        this.setupCartFunctionality();
    }

    setupMobileMenu() {
        const mobileToggle = document.querySelector('.mobile-menu-toggle');
        const mobileMenu = document.querySelector('.mobile-menu');
        
        if (mobileToggle && mobileMenu) {
            mobileToggle.addEventListener('click', () => {
                mobileMenu.classList.toggle('open');
                mobileToggle.setAttribute('aria-expanded', 
                    mobileMenu.classList.contains('open'));
            });

            // Close mobile menu when clicking outside
            document.addEventListener('click', (e) => {
                if (!mobileToggle.contains(e.target) && !mobileMenu.contains(e.target)) {
                    mobileMenu.classList.remove('open');
                    mobileToggle.setAttribute('aria-expanded', 'false');
                }
            });
        }
    }

    setupSmoothScrolling() {
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                const href = this.getAttribute('href');
                if (href === '#') return;
                
                e.preventDefault();
                const target = document.querySelector(href);
                
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    }

    setupProductInteractions() {
        // Product card hover effects
        document.querySelectorAll('.product-card').forEach(card => {
            card.addEventListener('mouseenter', this.onProductCardHover.bind(this));
            card.addEventListener('mouseleave', this.onProductCardLeave.bind(this));
        });

        // Quick view functionality
        document.querySelectorAll('[data-quick-view]').forEach(btn => {
            btn.addEventListener('click', this.openQuickView.bind(this));
        });

        // Wishlist toggle
        document.querySelectorAll('[data-wishlist-toggle]').forEach(btn => {
            btn.addEventListener('click', this.toggleWishlist.bind(this));
        });
    }

    setupCartFunctionality() {
        // Add to cart notifications
        document.addEventListener('salla:cart.item.added', this.onItemAddedToCart.bind(this));
        document.addEventListener('salla:cart.item.removed', this.onItemRemovedFromCart.bind(this));
    }

    onProductCardHover(e) {
        const card = e.currentTarget;
        const quickActions = card.querySelector('.product-quick-actions');
        
        if (quickActions) {
            quickActions.style.opacity = '1';
            quickActions.style.transform = 'translateX(0)';
        }
    }

    onProductCardLeave(e) {
        const card = e.currentTarget;
        const quickActions = card.querySelector('.product-quick-actions');
        
        if (quickActions && window.innerWidth > 480) {
            quickActions.style.opacity = '0';
            quickActions.style.transform = 'translateX(-10px)';
        }
    }

    openQuickView(e) {
        e.preventDefault();
        const productId = e.currentTarget.dataset.productId;
        
        if (typeof salla !== 'undefined' && salla.product) {
            salla.product.getDetails(productId).then(product => {
                // Handle quick view modal
                this.showQuickViewModal(product);
            });
        }
    }

    toggleWishlist(e) {
        e.preventDefault();
        const productId = e.currentTarget.dataset.productId;
        const icon = e.currentTarget.querySelector('salla-icon');
        
        if (typeof salla !== 'undefined' && salla.wishlist) {
            salla.wishlist.toggle(productId).then(response => {
                if (response.action === 'added') {
                    icon.setAttribute('name', 'heart-filled');
                    this.showNotification('تم إضافة المنتج إلى المفضلة', 'success');
                } else {
                    icon.setAttribute('name', 'heart');
                    this.showNotification('تم إزالة المنتج من المفضلة', 'info');
                }
            });
        }
    }

    onItemAddedToCart(event) {
        const { item } = event.detail;
        this.showNotification(`تم إضافة ${item.name} إلى السلة`, 'success');
        this.updateCartCount();
    }

    onItemRemovedFromCart(event) {
        const { item } = event.detail;
        this.showNotification(`تم إزالة ${item.name} من السلة`, 'info');
        this.updateCartCount();
    }

    updateCartCount() {
        if (typeof salla !== 'undefined' && salla.cart) {
            salla.cart.getCount().then(count => {
                const cartCountElements = document.querySelectorAll('.cart-count');
                cartCountElements.forEach(element => {
                    element.textContent = count;
                    element.style.display = count > 0 ? 'flex' : 'none';
                });
            });
        }
    }

    showNotification(message, type = 'info') {
        // Create notification element
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <div class="notification-content">
                <salla-icon name="${this.getNotificationIcon(type)}"></salla-icon>
                <span>${message}</span>
            </div>
            <button class="notification-close" aria-label="إغلاق">
                <salla-icon name="close"></salla-icon>
            </button>
        `;

        // Add styles
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: ${this.getNotificationColor(type)};
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            transform: translateX(100%);
            transition: transform 0.3s ease;
            max-width: 300px;
        `;

        // Add to DOM
        document.body.appendChild(notification);

        // Animate in
        setTimeout(() => {
            notification.style.transform = 'translateX(0)';
        }, 100);

        // Setup close functionality
        const closeBtn = notification.querySelector('.notification-close');
        closeBtn.addEventListener('click', () => {
            this.removeNotification(notification);
        });

        // Auto remove after 5 seconds
        setTimeout(() => {
            this.removeNotification(notification);
        }, 5000);
    }

    removeNotification(notification) {
        notification.style.transform = 'translateX(100%)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }

    getNotificationIcon(type) {
        const icons = {
            success: 'check-circle',
            error: 'alert-circle',
            warning: 'alert-triangle',
            info: 'info-circle'
        };
        return icons[type] || icons.info;
    }

    getNotificationColor(type) {
        const colors = {
            success: '#10b981',
            error: '#ef4444',
            warning: '#f59e0b',
            info: '#3b82f6'
        };
        return colors[type] || colors.info;
    }

    initializeComponents() {
        // Initialize any custom components
        this.initializeProductSliders();
        this.initializeImageGalleries();
        this.initializeFilterSortOptions();
    }

    initializeProductSliders() {
        // Initialize product sliders if needed
        const sliders = document.querySelectorAll('.products-slider');
        sliders.forEach(slider => {
            // Custom slider initialization logic
        });
    }

    initializeImageGalleries() {
        // Initialize image galleries
        const galleries = document.querySelectorAll('.image-gallery');
        galleries.forEach(gallery => {
            // Custom gallery initialization logic
        });
    }

    initializeFilterSortOptions() {
        // Initialize filter and sort options
        const filters = document.querySelectorAll('.filter-options');
        filters.forEach(filter => {
            // Custom filter initialization logic
        });
    }

    setupSallaIntegration() {
        // Wait for Salla to be ready
        document.addEventListener('salla:ready', () => {
            console.log('Salla is ready');
            this.updateCartCount();
            this.setupSallaEventListeners();
        });
    }

    setupSallaEventListeners() {
        // Listen to Salla events
        document.addEventListener('salla:cart.updated', this.updateCartCount.bind(this));
        document.addEventListener('salla:user.logged_in', this.onUserLogin.bind(this));
        document.addEventListener('salla:user.logged_out', this.onUserLogout.bind(this));
    }

    onUserLogin(event) {
        console.log('User logged in:', event.detail);
        // Handle user login
        window.location.reload();
    }

    onUserLogout(event) {
        console.log('User logged out:', event.detail);
        // Handle user logout
        window.location.reload();
    }
}

// Initialize theme when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    new DigitalKeysTheme();
});

// Export for external use
window.DigitalKeysTheme = DigitalKeysTheme;
