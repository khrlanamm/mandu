#!/usr/bin/env python3
"""Membuat aset gambar Play Store MANDU 2.0: ikon, gambar fitur, dan screenshot
promosi (gradasi + judul + bingkai HP berisi tangkapan layar asli).

Butuh: rsvg-convert, ImageMagick (magick), dan Google Chrome (dipakai headless
untuk merender HTML/CSS ke PNG pada ukuran piksel yang presisi).

Sumber:
  - design/logo/mandu-symbol.svg      simbol MANDU
  - store/raw/00-beranda-clean.png    tangkapan layar beranda siswa (sumber ikon layanan)
  - store/raw/*.png                   tangkapan layar lain untuk tiap slide promosi

Jalankan dari root repo: python3 tool/store/generate.py
"""
import base64
import os
import subprocess

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
RAW = f"{ROOT}/store/raw"
STORE = f"{ROOT}/store"
TMP = f"{STORE}/.tmp"
CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

os.makedirs(STORE, exist_ok=True)
os.makedirs(TMP, exist_ok=True)


def b64(path):
    with open(path, "rb") as f:
        return base64.b64encode(f.read()).decode("ascii")


def sh(cmd):
    subprocess.run(cmd, check=True)


def render_html(html: str, out_png: str, w: int, h: int):
    html_path = f"{TMP}/_render.html"
    with open(html_path, "w") as f:
        f.write(html)
    sh([
        CHROME, "--headless=new", f"--screenshot={out_png}",
        f"--window-size={w},{h}", "--force-device-scale-factor=1",
        "--hide-scrollbars", "--default-background-color=00000000",
        "--no-sandbox", f"file://{html_path}",
    ])


# ---------------------------------------------------------------------------
# 1. Ikon aplikasi (512x512, latar putih — sama seperti launcher icon Android)
# ---------------------------------------------------------------------------
def make_icon():
    symbol = f"{TMP}/symbol358.png"
    sh(["rsvg-convert", "-w", "358", "-h", "358", f"{ROOT}/design/logo/mandu-symbol.svg", "-o", symbol])
    sh(["magick", "-size", "512x512", "xc:#FFFFFF", symbol, "-gravity", "center", "-composite", f"{STORE}/icon-512.png"])


# ---------------------------------------------------------------------------
# 2. Potong 5 ikon layanan dari tangkapan layar beranda (Lapor, Curhat,
#    Aspirasi, Bantuan, Edukasi) supaya gambar fitur pakai ikon asli aplikasi.
# ---------------------------------------------------------------------------
ICON_CROPS = {
    "lapor": (98, 1098),
    "curhat": (589, 1098),
    "aspirasi": (98, 1518),
    "bantuan": (589, 1518),
    "edukasi": (98, 1998),
}


def crop_service_icons():
    src = f"{RAW}/00-beranda-clean.png"
    for name, (x, y) in ICON_CROPS.items():
        sh(["magick", src, "-crop", f"132x132+{x}+{y}", "+repage", f"{TMP}/icon-{name}.png"])


# ---------------------------------------------------------------------------
# 3. Gambar fitur (1024x500)
# ---------------------------------------------------------------------------
def make_feature_graphic():
    logo = b64(f"{TMP}/logo.png")
    icons = {name: b64(f"{TMP}/icon-{name}.png") for name in ICON_CROPS}
    html = f"""<!DOCTYPE html><html><head><meta charset="utf-8"><style>
      * {{ margin:0; padding:0; box-sizing:border-box; }}
      html,body {{ width:1024px; height:500px; overflow:hidden; }}
      body {{
        font-family: -apple-system, "Helvetica Neue", Arial, sans-serif;
        background: radial-gradient(120% 160% at 8% 8%, #2A4FCC 0%, #1E3A8A 45%, #0E1B3D 100%);
        display:flex; flex-direction:column; justify-content:center; padding:0 64px;
      }}
      .brand {{ display:flex; align-items:center; gap:14px; margin-bottom:18px; }}
      .brand img {{ width:52px; height:52px; }}
      .brand-text .name {{ font-size:34px; font-weight:800; color:#fff; letter-spacing:-0.5px; }}
      .brand-text .name span {{ font-size:20px; font-weight:600; opacity:.75; margin-left:4px; }}
      .tagline {{ color:#C7D3F5; font-size:22px; font-weight:500; margin-bottom:30px; }}
      .services {{ display:flex; gap:22px; }}
      .service {{ display:flex; flex-direction:column; align-items:center; gap:10px; }}
      .service img {{ width:64px; height:64px; border-radius:18px; }}
      .service span {{ color:#fff; font-size:17px; font-weight:600; }}
    </style></head><body>
      <div class="brand"><img src="data:image/png;base64,{logo}">
        <div class="brand-text"><div class="name">MANDU<span>2.0</span></div></div></div>
      <div class="tagline">Teman Mengadu, Sekolah Berbenah</div>
      <div class="services">
        <div class="service"><img src="data:image/png;base64,{icons['lapor']}"><span>Lapor</span></div>
        <div class="service"><img src="data:image/png;base64,{icons['curhat']}"><span>Curhat</span></div>
        <div class="service"><img src="data:image/png;base64,{icons['aspirasi']}"><span>Aspirasi</span></div>
        <div class="service"><img src="data:image/png;base64,{icons['bantuan']}"><span>Bantuan</span></div>
        <div class="service"><img src="data:image/png;base64,{icons['edukasi']}"><span>Edukasi</span></div>
      </div>
    </body></html>"""
    render_html(html, f"{STORE}/feature-graphic.png", 1024, 500)


# ---------------------------------------------------------------------------
# 4. Screenshot promosi: gradasi + judul + bingkai HP berisi tangkapan layar asli
# ---------------------------------------------------------------------------
PHONE_TEMPLATE = """<!DOCTYPE html><html><head><meta charset="utf-8"><style>
  * {{ margin:0; padding:0; box-sizing:border-box; }}
  html,body {{ width:{w}px; height:{h}px; overflow:hidden; }}
  body {{
    font-family: -apple-system, "Helvetica Neue", Arial, sans-serif;
    background: radial-gradient(120% 90% at 50% -10%, #2A4FCC 0%, #1E3A8A 45%, #0E1B3D 100%);
    display:flex; flex-direction:column; align-items:center; position:relative;
  }}
  .brand {{ position:absolute; top:56px; left:56px; display:flex; align-items:center; gap:14px; }}
  .brand img {{ width:56px; height:56px; }}
  .brand span {{ color:#fff; font-weight:800; font-size:30px; letter-spacing:-0.5px; }}
  .headline {{ margin-top:170px; width:900px; text-align:center; color:#fff; font-weight:800;
    font-size:60px; line-height:1.18; letter-spacing:-0.5px; }}
  .sub {{ margin-top:18px; width:820px; text-align:center; color:#C7D3F5; font-size:28px; font-weight:500; }}
  .phone-wrap {{ margin-top:56px; position:relative; width:{pw}px; height:{ph}px; }}
  .phone-frame {{ width:100%; height:100%; border-radius:64px; background:#0B0F1E; padding:16px;
    box-shadow: 0 40px 90px rgba(0,0,0,0.45); display:flex; align-items:center; justify-content:center; }}
  .phone-screen {{ width:100%; height:100%; border-radius:48px; overflow:hidden; background:#fff; }}
  .phone-screen img {{ width:100%; height:100%; object-fit:cover; object-position:top; display:block; }}
  .notch {{ position:absolute; top:16px; left:50%; transform:translateX(-50%); width:120px; height:28px;
    background:#0B0F1E; border-radius:0 0 20px 20px; z-index:2; }}
</style></head><body>
  <div class="brand"><img src="data:image/png;base64,{logo}"><span>MANDU</span></div>
  <div class="headline">{headline}</div>
  {sub_html}
  <div class="phone-wrap"><div class="notch"></div>
    <div class="phone-frame"><div class="phone-screen"><img src="data:image/png;base64,{shot}"></div></div>
  </div>
</body></html>"""

LANDSCAPE_TEMPLATE = """<!DOCTYPE html><html><head><meta charset="utf-8"><style>
  * {{ margin:0; padding:0; box-sizing:border-box; }}
  html,body {{ width:{w}px; height:{h}px; overflow:hidden; }}
  body {{
    font-family: -apple-system, "Helvetica Neue", Arial, sans-serif;
    background: radial-gradient(120% 140% at 15% 0%, #2A4FCC 0%, #1E3A8A 45%, #0E1B3D 100%);
    display:flex; align-items:center; justify-content:center; gap:90px; position:relative;
  }}
  .brand {{ position:absolute; top:48px; left:64px; display:flex; align-items:center; gap:14px; }}
  .brand img {{ width:50px; height:50px; }}
  .brand span {{ color:#fff; font-weight:800; font-size:28px; letter-spacing:-0.5px; }}
  .text-col {{ width:620px; }}
  .headline {{ color:#fff; font-weight:800; font-size:56px; line-height:1.18; letter-spacing:-0.5px; }}
  .sub {{ margin-top:20px; color:#C7D3F5; font-size:26px; font-weight:500; }}
  .phone-wrap {{ position:relative; width:{pw}px; height:{ph}px; }}
  .phone-frame {{ width:100%; height:100%; border-radius:56px; background:#0B0F1E; padding:14px;
    box-shadow: 0 40px 90px rgba(0,0,0,0.45); }}
  .phone-screen {{ width:100%; height:100%; border-radius:42px; overflow:hidden; background:#fff; }}
  .phone-screen img {{ width:100%; height:100%; object-fit:cover; object-position:top; display:block; }}
  .notch {{ position:absolute; top:14px; left:50%; transform:translateX(-50%); width:100px; height:24px;
    background:#0B0F1E; border-radius:0 0 16px 16px; z-index:2; }}
</style></head><body>
  <div class="brand"><img src="data:image/png;base64,{logo}"><span>MANDU</span></div>
  <div class="text-col"><div class="headline">{headline}</div>{sub_html}</div>
  <div class="phone-wrap"><div class="notch"></div>
    <div class="phone-frame"><div class="phone-screen"><img src="data:image/png;base64,{shot}"></div></div>
  </div>
</body></html>"""

# (nomor urut tampil, judul, subjudul, berkas sumber di store/raw/)
SLIDES = [
    ("01-beranda", "5 layanan sekolah\ndalam satu aplikasi", "Lapor, Curhat, Aspirasi, Butuh Bantuan, Edukasi", "00-beranda-clean.png"),
    ("02-lapor", "Lapor masalah\nsekali klik", "Sekolah memverifikasi dan menindaklanjuti", "02-lapor-kategori.png"),
    ("03-aktivitas", "Pantau laporanmu\nsampai selesai", "Status jelas di setiap tahap", "09-aktivitas.png"),
    ("04-curhat", "Curhat rahasia\ndengan Guru BK", "Hanya kamu dan konselor yang membaca", "04-curhat-list.png"),
    ("05-aspirasi", "Aspirasi ditanggapi\nsekolah", "Bisa dikirim tanpa masuk akun", "06-aspirasi-papan.png"),
    ("06-bantuan", "Butuh bantuan?\nSatu tombol saja", "Tidak perlu menjelaskan panjang lebar", "07-bantuan.png"),
    ("07-edukasi", "Bacaan dan info\nbeasiswa", "Anti-perundungan, layanan BK, dan lainnya", "08-edukasi.png"),
    ("08-dashboard", "Dashboard untuk\nsekolah", "Pantau semua laporan dan tren bulanan", "13-dashboard-charts.png"),
]


def make_screenshots():
    logo = b64(f"{TMP}/logo.png")
    for out_name, headline, sub, shot_file in SLIDES:
        shot = b64(f"{RAW}/{shot_file}")
        sub_html = f'<div class="sub">{sub}</div>' if sub else ""
        head_html = headline.replace("\n", "<br>")

        html = PHONE_TEMPLATE.format(w=1080, h=1920, pw=620, ph=1390, logo=logo, headline=head_html, sub_html=sub_html, shot=shot)
        render_html(html, f"{STORE}/{out_name}-phone.png", 1080, 1920)

        html = LANDSCAPE_TEMPLATE.format(w=1920, h=1200, pw=420, ph=940, logo=logo, headline=head_html, sub_html=sub_html, shot=shot)
        render_html(html, f"{STORE}/{out_name}-tablet7.png", 1920, 1200)
        render_html(html, f"{STORE}/{out_name}-tablet10.png", 1920, 1200)
        print("slide", out_name)


if __name__ == "__main__":
    sh(["rsvg-convert", "-w", "200", "-h", "200", f"{ROOT}/design/logo/mandu-symbol.svg", "-o", f"{TMP}/logo.png"])
    make_icon()
    crop_service_icons()
    make_feature_graphic()
    make_screenshots()
    print("Selesai. Aset ada di store/.")
