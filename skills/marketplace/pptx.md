---
name: pptx
description: "Use this skill any time a .pptx file is involved in any way — as input, output, or both. This includes: creating slide decks, pitch decks, or presentations; reading, parsing, or extracting text from any .pptx file (even if the extracted content will be used elsewhere, like in an email or summary); editing, modifying, or updating existing presentations; combining or splitting slide files; working with templates, layouts, speaker notes, or comments. Trigger whenever the user mentions 'deck,' 'slides,' 'presentation,' or references a .pptx filename, regardless of what they plan to do with the content afterward. If a .pptx file needs to be opened, created, or touched, use this skill."
license: Proprietary. LICENSE.txt has complete terms
---

# PPTX Skill

## Quick Reference

| Task | Guide |
|------|-------|
| Read/analyze content | `python -m markitdown presentation.pptx` |
| Edit or create from template | Unpack → edit XML → repack |
| Create from scratch | Use pptxgenjs |

---

## Reading Content

```bash
# Text extraction
python -m markitdown presentation.pptx

# Visual overview
python scripts/thumbnail.py presentation.pptx

# Raw XML
python scripts/office/unpack.py presentation.pptx unpacked/
```

---

## Design Ideas

**Don't create boring slides.** Plain bullets on a white background won't impress anyone.

### Before Starting

- **Pick a bold, content-informed color palette**: Should feel designed for THIS topic.
- **Dominance over equality**: One color dominates (60-70%), with 1-2 supporting tones and one sharp accent.
- **Commit to a visual motif**: Pick ONE distinctive element and repeat it.

### Color Palettes

| Theme | Primary | Secondary | Accent |
|-------|---------|-----------|--------|
| **Midnight Executive** | `1E2761` | `CADCFC` | `FFFFFF` |
| **Forest & Moss** | `2C5F2D` | `97BC62` | `F5F5F5` |
| **Coral Energy** | `F96167` | `F9E795` | `2F3C7E` |
| **Warm Terracotta** | `B85042` | `E7E8D1` | `A7BEAE` |
| **Charcoal Minimal** | `36454F` | `F2F2F2` | `212121` |
| **Teal Trust** | `028090` | `00A896` | `02C39A` |

### Typography

| Element | Size |
|---------|------|
| Slide title | 36-44pt bold |
| Section header | 20-24pt bold |
| Body text | 14-16pt |
| Captions | 10-12pt muted |

### Avoid

- Repeating the same layout across slides
- Center-aligned body text
- Text-only slides — add images, icons, charts, or visual elements
- **Accent lines under titles** — hallmark of AI-generated slides
- Low-contrast elements

---

## QA (Required)

**Assume there are problems. Your job is to find them.**

### Content QA

```bash
python -m markitdown output.pptx
```

Check for leftover placeholder text:
```bash
python -m markitdown output.pptx | grep -iE "xxxx|lorem|ipsum"
```

### Visual QA

Convert slides to images:
```bash
python scripts/office/soffice.py --headless --convert-to pdf output.pptx
pdftoppm -jpeg -r 150 output.pdf slide
```

Use subagents to inspect visually — you've been staring at the code and will see what you expect, not what's there.

### Verification Loop

1. Generate → Convert → Inspect
2. List issues found (if none found, look again more critically)
3. Fix issues
4. Re-verify affected slides
5. Repeat until a full pass reveals no new issues

---

## Dependencies

- `pip install "markitdown[pptx]"` - text extraction
- `npm install -g pptxgenjs` - creating from scratch
- LibreOffice (`soffice`) - PDF conversion
- Poppler (`pdftoppm`) - PDF to images
