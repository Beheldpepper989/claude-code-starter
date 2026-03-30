---
name: xlsx
description: "Use this skill any time a spreadsheet file is the primary input or output. This means any task where the user wants to: open, read, edit, or fix an existing .xlsx, .xlsm, .csv, or .tsv file (e.g., adding columns, computing formulas, formatting, charting, cleaning messy data); create a new spreadsheet from scratch or from other data sources; or convert between tabular file formats. Trigger especially when the user references a spreadsheet file by name or path — even casually (like 'the xlsx in my downloads') — and wants something done to it or produced from it. Also trigger for cleaning or restructuring messy tabular data files into proper spreadsheets. The deliverable must be a spreadsheet file. Do NOT trigger when the primary deliverable is a Word document, HTML report, standalone Python script, database pipeline, or Google Sheets API integration, even if tabular data is involved."
license: Proprietary. LICENSE.txt has complete terms
---

# Requirements for Outputs

## All Excel files

- Use a consistent, professional font (e.g., Arial, Times New Roman)
- Every Excel model must be delivered with ZERO formula errors (#REF!, #DIV/0!, #VALUE!, #N/A, #NAME?)
- Preserve existing templates when updating — match existing format, style, and conventions exactly

## Financial models

### Color Coding
- **Blue text**: Hardcoded inputs
- **Black text**: ALL formulas and calculations
- **Green text**: Links from other worksheets within same workbook
- **Red text**: External links to other files
- **Yellow background**: Key assumptions needing attention

### Number Formatting
- **Years**: Format as text strings ("2024" not "2,024")
- **Currency**: Use $#,##0; specify units in headers ("Revenue ($mm)")
- **Zeros**: Use "-" format: "$#,##0;($#,##0);-"
- **Percentages**: Default to 0.0%
- **Negative numbers**: Use parentheses (123) not minus -123

---

# XLSX creation, editing, and analysis

## CRITICAL: Use Formulas, Not Hardcoded Values

```python
# WRONG
total = df['Sales'].sum()
sheet['B10'] = total  # Hardcodes 5000

# CORRECT
sheet['B10'] = '=SUM(B2:B9)'
```

This applies to ALL calculations — totals, percentages, ratios, differences, etc.

## Common Workflow
1. **Choose tool**: pandas for data, openpyxl for formulas/formatting
2. **Create/Load**: Create new workbook or load existing file
3. **Modify**: Add/edit data, formulas, and formatting
4. **Save**: Write to file
5. **Recalculate formulas (MANDATORY IF USING FORMULAS)**:
   ```bash
   python scripts/recalc.py output.xlsx
   ```
6. **Verify and fix any errors** — check the returned JSON for `#REF!`, `#DIV/0!`, etc.

## Creating new Excel files

```python
from openpyxl import Workbook
from openpyxl.styles import Font, PatternFill, Alignment

wb = Workbook()
sheet = wb.active

sheet['A1'] = 'Hello'
sheet['B2'] = '=SUM(A1:A10)'

sheet['A1'].font = Font(bold=True, color='FF0000')
sheet['A1'].fill = PatternFill('solid', start_color='FFFF00')
sheet.column_dimensions['A'].width = 20

wb.save('output.xlsx')
```

## Editing existing Excel files

```python
from openpyxl import load_workbook

wb = load_workbook('existing.xlsx')
sheet = wb.active

sheet['A1'] = 'New Value'
sheet.insert_rows(2)
sheet.delete_cols(3)

wb.save('modified.xlsx')
```

**Warning**: If opened with `data_only=True` and saved, formulas are replaced with values and permanently lost.

## Formula Verification Checklist

- [ ] Test 2-3 sample references before building the full model
- [ ] Row offset: Excel rows are 1-indexed (DataFrame row 5 = Excel row 6)
- [ ] Check for NaN values with `pd.notna()`
- [ ] Division by zero: check denominators before using `/` in formulas
- [ ] Cross-sheet references: use correct format `Sheet1!A1`

## Best Practices

- **pandas**: Best for data analysis, bulk operations, and simple data export
- **openpyxl**: Best for complex formatting, formulas, and Excel-specific features
- Write minimal, concise Python code — avoid unnecessary comments and redundant operations
