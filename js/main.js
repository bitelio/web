require('./particles');

window.dataLayer = window.dataLayer || [];
window.contact = function() {
  window.dataLayer.push(('event', 'email'))
  window.location.href = 'mailto:info@bitelio.com'
}
