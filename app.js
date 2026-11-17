const $ = id => document.getElementById(id);

// البيانات جاية من config.js (window.CONFIG)
const c = window.CONFIG;

// ── عنوان الصفحة والـ meta tags
const names     = c.groom + ' ♥ ' + c.bride;
const fullTitle = c.pageTitle || ('دعوة عقد قران ' + names);
const desc      = 'يسعدنا دعوتكم لعقد قران ' + names + '. ' + (c.coverSubtitle || '');
const shareDesc = (c.coverSubtitle || '') + ' اضغط على الظرف لفتح الدعوة';
const su        = c.siteUrl      || '';
const img       = c.previewImage || '';

document.title = fullTitle;

function setMeta(sel, attr, val) {
  let m = document.querySelector(sel);
  if (!m) { m = document.createElement('meta'); m.setAttribute(attr.split('=')[0], attr.split('=')[1]); document.head.appendChild(m); }
  m.content = val;
}
function setMetaName(name, val)     { setMeta('meta[name="'+name+'"]',         'name='+name, val); }
function setMetaProp(prop, val)     { setMeta('meta[property="'+prop+'"]',     'property='+prop, val); }

setMetaName('description',           desc);
setMetaProp('og:title',              fullTitle);
setMetaProp('og:description',        shareDesc);
setMetaProp('og:image:alt',          shareDesc);
setMetaName('twitter:title',         fullTitle);
setMetaName('twitter:description',   shareDesc);
setMetaProp('og:url',                su);
setMetaProp('og:image',              img);
setMetaProp('og:image:secure_url',   img);
setMetaProp('og:image:type',         'image/png');
setMetaProp('og:image:width',        '1200');
setMetaProp('og:image:height',       '630');
setMetaName('twitter:image',         img);
setMetaProp('og:locale',             'ar_EG');

let can = document.querySelector('link[rel="canonical"]');
if (!can) { can = document.createElement('link'); can.rel = 'canonical'; document.head.appendChild(can); }
can.href = su;

// ── الشاشة الافتتاحية
$('coverEyebrow').textContent  = c.coverEyebrow || '';
$('coverSubtitle').textContent = c.coverSubtitle || '';
const h1 = $('coverTitle');
h1.insertBefore(document.createTextNode(c.groom + ' ♥ ' + c.bride + ' '), h1.firstChild);
$('openBtn').textContent = c.coverButton || '';
$('envelope').setAttribute('aria-label', 'افتح دعوة ' + c.groom + ' ♥ ' + c.bride);

// ── البطاقة الداخلية
$('groomName').textContent   = c.groom    || '';
$('brideName').textContent   = c.bride    || '';
$('cardSub').textContent     = c.cardSub  || '';
$('cardMessage').innerHTML   = (c.cardMessage || '').replace(/\n/g, '<br>');

// ── التفاصيل
$('detailsTitle').textContent    = c.detailsTitle    || '';
$('detailsSubtitle').textContent = c.detailsSubtitle || '';
$('dateText').textContent        = c.dateLabel       || '';
$('timeText').textContent        = c.timeLabel       || '';
$('venueText').textContent       = c.venue           || '';
$('countdownTitle').textContent  = c.countdownTitle  || '';

// ── الأزرار والروابط
$('mapLink').textContent = c.mapBtn || '📍 الموقع';
$('mapLink').href        = c.mapUrl || '#';
$('shareBtn').textContent = c.shareBtn || '💌 شارك';

// ── الفوتر
$('footerTitle').textContent = c.footerTitle || '';
$('footerSub').textContent   = c.footerSub   || '';

// ── الموسيقى
const src = document.querySelector('#music source');
if (src && c.musicFile) src.src = c.musicFile;

// ── النجوم
for (let i = 0; i < 75; i++) {
  const s = document.createElement('i');
  s.className = 'star';
  s.style.left = Math.random() * 100 + '%';
  s.style.top  = Math.random() * 100 + '%';
  s.style.animationDelay = Math.random() * 4 + 's';
  $('stars').append(s);
}

// ── البتلات
function petals(n = 1) {
  for (let i = 0; i < n; i++) {
    const p = document.createElement('span');
    p.className = 'petal';
    p.textContent = ['🌸', '✿', '♥', '✦'][Math.floor(Math.random() * 4)];
    p.style.left = Math.random() * 100 + '%';
    p.style.animationDuration = (6 + Math.random() * 6) + 's';
    p.style.fontSize = (12 + Math.random() * 16) + 'px';
    $('petals').append(p);
    setTimeout(() => p.remove(), 12500);
  }
}

// ── الموسيقى
const music = $('music');
function toggleMusic() {
  if (music.paused) {
    music.play().then(() => { $('musicBtn').textContent = '♫'; $('musicBtn').classList.add('playing'); })
                 .catch(() => { $('musicBtn').textContent = '♪'; $('musicBtn').classList.remove('playing'); });
  } else {
    music.pause(); $('musicBtn').textContent = '♪'; $('musicBtn').classList.remove('playing');
  }
}

// ── فتح الدعوة
let invitationOpened = false;
function openInvitation() {
  if (invitationOpened) return;
  invitationOpened = true;
  $('openBtn').disabled = true;
  $('envelope').classList.add('open');
  music.play().then(() => $('musicBtn').classList.add('playing')).catch(() => { $('musicBtn').title = 'اضغط لتشغيل الأغنية'; });
  setTimeout(() => {
    $('opening').classList.add('hide');
    $('site').classList.add('visible');
    fitInvitation();
    $('musicBtn').hidden = false;
    petals(24);
    setInterval(() => petals(2), 1100);
    setTimeout(() => observer.observe($('countdown')), 50);
  }, 1400);
}
$('openBtn').addEventListener('click', openInvitation);
$('envelope').addEventListener('click', openInvitation);
$('envelope').addEventListener('keydown', e => { if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); openInvitation(); } });
$('musicBtn').addEventListener('click', toggleMusic);

// ── تناسب الحجم
function fitInvitation() {
  const card = $('invitationCard'), site = $('site');
  if (!card || !site) return;
  site.classList.remove('scroll-layout');
  const height = window.innerHeight, width = document.documentElement.clientWidth;
  const scale = Math.min(1, (height - 88) / card.offsetHeight, (width - 24) / card.offsetWidth);
  if (scale < .9) {
    site.classList.add('scroll-layout'); card.style.setProperty('--card-scale', 1); card.style.top = '';
  } else {
    card.style.setProperty('--card-scale', scale); card.style.top = ((height - 64) / 2) + 'px';
  }
}
fitInvitation();
window.addEventListener('resize', fitInvitation);
if (window.visualViewport) window.visualViewport.addEventListener('resize', fitInvitation);
if (document.fonts) document.fonts.ready.then(fitInvitation);
new ResizeObserver(fitInvitation).observe($('invitationCard'));

// ── Intersection Observer للـ reveal
const observer = new IntersectionObserver(entries => entries.forEach(e => {
  if (e.isIntersecting) { e.target.classList.add('show'); observer.unobserve(e.target); }
}), { threshold: .12 });
document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

// ── العد التنازلي
function updateClock() {
  const diff = Math.max(0, new Date(c.date).getTime() - Date.now());
  const units = [Math.floor(diff / 86400000), Math.floor(diff / 3600000) % 24, Math.floor(diff / 60000) % 60, Math.floor(diff / 1000) % 60];
  ['days', 'hours', 'minutes', 'seconds'].forEach((id, i) => $(id).textContent = String(units[i]).padStart(2, '0'));
}
updateClock();
setInterval(updateClock, 1000);

// ── زر المشاركة
$('shareBtn').addEventListener('click', async () => {
  const data = { title: fullTitle, text: shareDesc, url: c.siteUrl || location.href };
  try {
    if (navigator.share) await navigator.share(data);
    else { await navigator.clipboard.writeText(location.href); alert('تم نسخ رابط الدعوة ♥'); }
  } catch (e) { if (e.name !== 'AbortError') alert('يمكنك نسخ رابط الصفحة ومشاركته'); }
});
