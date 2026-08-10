#!/bin/bash
# Regenerates index.html (contact sheet) and frontier-films-artifact.html (single shareable file)
# from whatever NN-*.html options are currently in this folder.
set -e
cd "$(dirname "$0")"

FILES=$(ls [0-9][0-9]-*.html 2>/dev/null | sort)
COUNT=$(echo "$FILES" | grep -c . || true)

# ---------- index.html : contact sheet ----------
{
cat <<'HEAD'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Frontier Films — Cover Options</title>
<style>
  :root{ --paper:#FBF8F0; --ink:#14120E; --muted:#6B6355; --rule:#D6CDB9; }
  *{box-sizing:border-box}
  body{margin:0;background:var(--paper);color:var(--ink);
    font-family:"Iowan Old Style","Palatino","Baskerville",Georgia,serif}
  header{padding:clamp(30px,5vw,58px) clamp(22px,3.4vw,46px) 24px;border-bottom:1px solid var(--ink)}
  header h1{margin:0;font-family:"Didot","Bodoni 72","Hoefler Text",serif;font-weight:400;
    font-size:clamp(30px,5vw,56px);line-height:1}
  header p{margin:14px 0 0;font-size:11px;letter-spacing:.26em;text-transform:uppercase;color:var(--muted)}
  header .note{margin:12px 0 0;font-size:15px;font-style:italic;color:var(--muted);max-width:64ch;
    line-height:1.6;text-transform:none;letter-spacing:0}
  .sheet{display:grid;grid-template-columns:repeat(auto-fill,minmax(360px,1fr))}
  .cell{border-right:1px solid var(--rule);border-bottom:1px solid var(--rule);padding:20px}
  .cap{display:flex;align-items:baseline;justify-content:space-between;gap:12px;margin-bottom:12px}
  .no{font-family:"Didot","Bodoni 72",serif;font-size:28px;line-height:1}
  .nm{font-size:10.5px;letter-spacing:.24em;text-transform:uppercase;color:var(--muted);text-align:right}
  .thumb{position:relative;width:100%;aspect-ratio:16/10;border:1px solid var(--rule);overflow:hidden;background:#fff}
  .thumb iframe{position:absolute;top:0;left:0;width:1440px;height:900px;border:0;
    transform:scale(.25);transform-origin:top left;pointer-events:none}
  .thumb a{position:absolute;inset:0;z-index:2}
  .open{display:inline-block;margin-top:11px;font-size:14px;font-style:italic;color:var(--ink);
    text-decoration:none;border-bottom:1px solid var(--rule)}
  footer{padding:32px clamp(22px,3.4vw,46px) 56px;font-size:11px;letter-spacing:.26em;
    text-transform:uppercase;color:var(--muted)}
  footer a{color:var(--ink);text-decoration:none;border-bottom:1px solid var(--rule);
    text-transform:none;letter-spacing:0;font-style:italic}
</style>
</head>
<body>
  <header>
    <h1>Frontier Films — Cover Options</h1>
HEAD
echo "    <p>$COUNT designs &nbsp;·&nbsp; Cream &amp; white &nbsp;·&nbsp; Serif &nbsp;·&nbsp; Wireframe geometry</p>"
cat <<'HEAD2'
    <p class="note">Contact sheet. Every thumbnail is the live page scaled down — click to open it full size. Each option is a single self-contained HTML file; all geometry is drawn as inline SVG, so there are no image files to lose.</p>
  </header>
  <div class="sheet">
HEAD2

for f in $FILES; do
  n="${f%%-*}"
  label="${f#*-}"; label="${label%.html}"; label="${label//-/ }"
  cat <<CELL
    <div class="cell">
      <div class="cap"><span class="no">$n</span><span class="nm">$label</span></div>
      <div class="thumb"><iframe src="$f" loading="lazy" scrolling="no" title="Option $n"></iframe><a href="$f" aria-label="Open option $n"></a></div>
      <a class="open" href="$f">Open option $n &rarr;</a>
    </div>
CELL
done

cat <<'TAILI'
  </div>
  <footer>
    Frontier Films &nbsp;·&nbsp; New York · Los Angeles &nbsp;·&nbsp;
    <a href="mailto:hello@frontier-film.com">hello@frontier-film.com</a> &nbsp;·&nbsp; © 2026 &nbsp;·&nbsp;
    <a href="frontier-films-artifact.html">All options in one file &rarr;</a>
  </footer>
</body>
</html>
TAILI
} > index.html

# ---------- frontier-films-artifact.html : one shareable file ----------
{
cat <<'HEAD3'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Frontier Films — Cover Options</title>
<style>
  :root{ --paper:#FBF8F0; --ink:#14120E; --muted:#6B6355; --rule:#D6CDB9; }
  *{box-sizing:border-box}
  html,body{margin:0;height:100%}
  body{background:var(--paper);color:var(--ink);
    font-family:"Iowan Old Style","Palatino","Baskerville",Georgia,serif;display:flex;flex-direction:column}
  header{padding:18px 24px 14px;border-bottom:1px solid var(--ink);flex:0 0 auto}
  .row{display:flex;flex-wrap:wrap;align-items:baseline;justify-content:space-between;gap:14px}
  h1{margin:0;font-family:"Didot","Bodoni 72","Hoefler Text",serif;font-weight:400;font-size:clamp(19px,2.6vw,28px)}
  header p{margin:0;font-size:10.5px;letter-spacing:.24em;text-transform:uppercase;color:var(--muted)}
  nav{display:flex;flex-wrap:wrap;gap:5px;margin-top:14px}
  nav button{font:inherit;font-size:13px;background:transparent;color:var(--muted);
    border:1px solid var(--rule);padding:4px 8px;cursor:pointer}
  nav button:hover{color:var(--ink);border-color:var(--ink)}
  nav button[aria-current="true"]{background:var(--ink);color:#FBF8F0;border-color:var(--ink)}
  .caption{padding:11px 24px;font-size:11.5px;letter-spacing:.2em;text-transform:uppercase;color:var(--muted);
    border-bottom:1px solid var(--rule);flex:0 0 auto;display:flex;justify-content:space-between;gap:12px}
  .caption em{text-transform:none;letter-spacing:0;font-size:13px}
  .stage{flex:1 1 auto;min-height:0;background:#fff}
  .stage iframe{width:100%;height:100%;border:0;display:block;background:#fff}
</style>
</head>
<body>
  <header>
    <div class="row">
      <h1>Frontier Films — Cover Options</h1>
      <p>Cream &amp; white · Serif · Wireframe geometry</p>
    </div>
    <nav id="nav"></nav>
  </header>
  <div class="caption"><span id="cap"></span><em>← → to move between options</em></div>
  <div class="stage"><iframe id="frame" title="Cover option"></iframe></div>
<script>
const OPTIONS = [
HEAD3

for f in $FILES; do
  n="${f%%-*}"
  label="${f#*-}"; label="${label%.html}"; label="${label//-/ }"
  b64=$(base64 < "$f" | tr -d '\n')
  printf '{"n":"%s","label":"%s","b64":"%s"},\n' "$n" "$label" "$b64"
done

cat <<'TAIL3'
];
const nav=document.getElementById('nav'), frame=document.getElementById('frame'), cap=document.getElementById('cap');
let current=0;
function show(i){
  current=i;
  const o=OPTIONS[i];
  frame.srcdoc = decodeURIComponent(escape(atob(o.b64)));
  cap.textContent = `Option ${o.n} — ${o.label}`;
  [...nav.children].forEach((b,j)=>b.setAttribute('aria-current', j===i ? 'true':'false'));
}
OPTIONS.forEach((o,i)=>{
  const b=document.createElement('button');
  b.type='button'; b.textContent=o.n; b.title=o.label;
  b.addEventListener('click',()=>show(i));
  nav.appendChild(b);
});
addEventListener('keydown',e=>{
  if(e.key==='ArrowRight') show((current+1)%OPTIONS.length);
  if(e.key==='ArrowLeft')  show((current-1+OPTIONS.length)%OPTIONS.length);
});
show(0);
</script>
</body>
</html>
TAIL3
} > frontier-films-artifact.html

echo "Rebuilt index.html + frontier-films-artifact.html from $COUNT options"
