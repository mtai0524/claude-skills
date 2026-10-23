---
name: qc-ui
description: TakakoMes only. Design or polish a page in the Takako Quality Control / QC Pro UI style (HeaderSection, GenericMudTable, tabs, chips, dialogs, forms, snackbar). Use when building a page or dialog in TakakoMes Web.QC or Web.QcPro, when the user types /qc-ui, or asks to make a screen look like Quality Control. In any other project, ask the user before applying it.
---

# QC UI style

This skill belongs to the TakakoMes project (a repo with `src/TakakoMes.Web.QcPro`). In TakakoMes apply it directly. In any other project, do not apply it: ask the user first whether to use this style there and how to map it to that project's components.

Build the page so it looks like the existing QC Pro pages. Reference pages, read one before writing:

- List: `src/TakakoMes.Web.QcPro/Components/Pages/QcPro/NewProducts/NewProductPage.razor`
- Detail with tabs: `.../QcPro/NewProducts/NewProductDetailPage.razor`
- Filter bar + list: `.../QcPro/Calibration/InstrumentPage.razor`
- Dialog: `.../QcPro/NewProducts/NewProductRegisterDialog.razor`
- Status chip: `.../QcPro/NewProducts/NewProductStatusChip.razor`

Older QC pages (`MudContainer` + `MudPaper`, `SettingsLayout`, `MudDataGrid`, `MudMenu` row actions) are legacy: do not copy them.

## Rules

- Screens show only data, inputs and buttons. No explanatory alerts, captions, legends, placeholders, empty-state sentences, emoji.
- Reuse shared components from `src/TakakoMes.Web/Components`; do not write a new table, header or confirm dialog.
- Colours come from the MudBlazor palette (`Color.*`, `var(--mud-palette-*)`). Primary is green `#76C16B` (`Routes.razor`); never hardcode hex.
- Page-specific CSS goes in a scoped `X.razor.css` next to the page.
- Text: Vietnamese in the page; `AppResources.*` for common words (Save, Cancel, Delete, Status).

## Page skeleton

No `MudContainer`/`MudPaper` wrapper, no breadcrumbs.

```razor
<PageTitle>Danh sách mã hàng mới</PageTitle>
<HeaderSection Title="Danh sách mã hàng mới">
    <MudStack Row Spacing="1">
        <MudButton Variant="Variant.Filled" Color="Color.Primary" StartIcon="@Icons.Material.Filled.Add">Đăng ký</MudButton>
        <MudButton Variant="Variant.Outlined" Color="Color.Primary" StartIcon="@Icons.Material.Filled.Upload">Import Excel</MudButton>
        <MudButton Variant="Variant.Filled" Color="Color.Success" StartIcon="@Icons.Material.Filled.FileDownload">Xuất Excel</MudButton>
    </MudStack>
</HeaderSection>
```

- Buttons: main = Filled Primary; secondary / back = Outlined Primary (`ArrowBack`); Excel export = Filled Success; delete = Filled Error (`Delete`). Always a `Icons.Material.Filled.*` start icon.
- Edit actions only render when the user may edit (`@if (_canEdit)`).
- Status chips next to the title go in `HeaderSection`'s `TitleAdornment`.
- Own filter bar: `<MudPaper Elevation="0" Outlined="true" Class="compact-form pa-2 mb-3">` + `<MudStack Row Spacing="2" AlignItems="AlignItems.Center" Wrap="Wrap.Wrap">`. Tab-like filters: `MudButtonGroup`, active Filled, others Outlined.

## List

```razor
<GenericMudTable TItem="NewProduct" @ref="_table" Items="Filtered" Height="calc(100vh - 300px)" RowsPerPage="100"
                 SearchKeyword="@_search" OnRowClick="Open" RowStyle="@(_ => "cursor:pointer")" Hover="true">
    <ToolbarContent><SettingsToolbar @bind-SearchString="_search" /></ToolbarContent>
    <HeaderTemplate>
        <MudTh><MudStack Row Spacing="0" AlignItems="AlignItems.Center">
            <MudTableSortLabel T="NewProduct" SortBy="x => x.Status">@AppResources.Status</MudTableSortLabel>
            <ColumnFilter @bind-Value="_status" Placeholder="@AppResources.Status" Options="@StatusOptions" />
        </MudStack></MudTh>
    </HeaderTemplate>
    <RowTemplate Context="p"><MudTd>@_table.HighlightText(p.ProductCode)</MudTd></RowTemplate>
</GenericMudTable>
```

- `GenericMudTable` is already Bordered, FixedHeader, Dense, paged, with Excel export. Use `IsLoading` instead of a separate spinner, `ShowToolbar="false"` when the page has its own filter bar.
- Filters live in the column headers (`ColumnFilter`), not in a separate panel.
- Row actions: `MudIconButton Size="Size.Small"` (Primary, delete Error), in `MudTooltip` when the icon is not obvious.
- Dates in tables `dd.MM.yy`.

## Tabs

```razor
<MudTabs Elevation="0" Rounded ApplyEffectsToContainer KeepPanelsAlive="true" SliderColor="Color.Primary" PanelClass="pt-1">
    <MudTabPanel Text="Chỉ thị đo" BadgeData="@BadgeOf(_product.Instructions.Count)" BadgeColor="Color.Primary">
```

`private static object? BadgeOf(int count) => count > 0 ? count : null;` Plain text labels, no icons. Error badge only for "waiting for me" counts.

## Status chips

- `<MudChip T="string" Label="true" Size="Size.Small" Color="...">`, Filled.
- Success = done / OK, Warning = in progress / missing / near due, Error = NG / overdue, Default = new / cancelled. Outlined for neutral info.
- Keep the text and colour mapping in one static `Info()` on a `XxxStatusChip.razor` component; a status column may colour the whole cell via `CellStyle(color)`.

## Dialogs

```razor
<MudDialog>
    <TitleContent><MudText Typo="Typo.h6">@Title</MudText></TitleContent>
    <DialogContent><MudGrid Spacing="2">…</MudGrid></DialogContent>
    <DialogActions>
        <MudButton Variant="Variant.Text" OnClick="@(() => MudDialog.Cancel())">@AppResources.Cancel</MudButton>
        <MudButton Variant="Variant.Filled" Color="Color.Primary" Disabled="_busy" OnClick="SaveAsync">@AppResources.Save</MudButton>
    </DialogActions>
</MudDialog>
```

- Each dialog has a `public static async Task<T?> ShowAsync(IDialogService dialogs, ...)` that opens it and returns the result. Options: `MaxWidth.Small` (forms) or `Large`/`ExtraLarge` (editors, images), `FullWidth = true, CloseButton = true, CloseOnEscapeKey = true, DisableBackdropClick = true`.
- Confirm: `await DialogService.OpenConfirmDialogAsync(AppResources.Delete, Icons.Material.Filled.Delete, $"Xoá {x.Name}?")`.

## Forms

- Every input: `Variant="Variant.Outlined" Margin="Margin.Dense" Label="..."`, laid out in `MudGrid Spacing="2"` + `MudItem xs="12" sm="6"`.
- Autocomplete: `CoerceValue="true" ResetValueOnEmptyText="false" SearchFunc=...`.
- Search box: `Immediate="true" DebounceInterval="250"`, `Adornment.Start` + `Icons.Material.Filled.Search`.
- Date: `MudDatePicker DateFormat="dd.MM.yyyy"`, range `MudDateRangePicker Clearable`.
- Dense grids of inputs: wrap in `.compact-form` (`wwwroot/global.css`).

## Feedback

- Snackbar: one short sentence with a period. `"Đã lưu."` Success, business-layer message as Warning, `$"Không đọc được file Excel: {ex.Message}"` Error.
- Busy: `Disabled="_busy"` on the button, `MudProgressLinear Indeterminate Color.Primary` or the table's `IsLoading`.
- Empty: the table's `NoDataText` only.

## Menu entry (QC Pro)

Add the screen in `src/TakakoMes.Web/Components/Pages/QcPro/QcProScreens.cs` only (`Screen(Href, Icon, Text, Roles)`, icons from `navbar/NavIcons.cs`), and put the same role constant on the page: `[Authorize(Roles = QcProScreens.XxxViewRoles)]`. QC menu entries are in `Layout/navbar/QualityNavGroup.razor`.

## Done

Build the module (`dotnet build src/TakakoMes.Web.QcPro/TakakoMes.Web.QcPro.csproj`) and compare the page side by side with a reference page above.
