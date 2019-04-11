# classyslides

This package provides the **classyslides** beamer theme and extensions.

## Getting Started

### 1. Register classycv source files

**Note:** The following instructions are for macOS 10.14.2 and assume that [MacTeX][2] is installed. Instructions for other platforms can be found in [this StackOverflow thread][1].

Clone this repository into your local `texmf` directory

```bash
cd ~/Library/texmf/tex/latex
git clone https://github.com/classysoftware/classyslides.git
```

Verify by running `ls -l`. The output should show an entry for the `classyslides` folder where (`<user>` and `<group>` are placeholders for your user name and user group).

```bash
ls -la
total 0
# ...
drwxr-xr-x  10 <user>  <group>  320 12 Jan 19:39 classyslides
```

Run `texhash` as super user to add classycv's class and style files to the index.

```bash
sudo texhash
```

### 2. Create project folder for your presentation and add content

Change to a directory of your choice and create a project folder (we simply use `~/Desktop` and `my-presentation` as the folder name in this example)

```bash
cd ~/Desktop
mkdir my-presentation
cd my-presentation
```

Next, add a file `my-presentation.tex` containing a presentation stub

```bash
cat <<EOF > my-presentation.tex
\documentclass{beamer}

\usetheme{classyslides}
\mode<presentation>

\title{Example}
\author[me]{Me \\ me@mail.com}
\date{\today}

\begin{document}

\frame{
\titlepage
}

\frame{
  \frametitle{First slide}
  \Huge\alert{Stay classy!}
}
\end{document}
EOF
```

### 3. Edit and compile output

Edit your presentation and compile it to PDF.

**Note:** If you don't know how to work with _Beamer_, have a look at the example presentations in the folder `examples/` or the quickstart presentation template in `quickstart/`.

Run the following command:

```bash
latexmk -pdfxe my-presentation.tex && open my-presentation.pdf
```

This should open a PDF viewer should and show a minimal presentation containing only a title slide and one content slide.

## About _classyslides_

**Classyslides** is a minimalistic beamer theme with focus on clear layout and efficient use of space.

### Core Features

- Preconfigured **block**, **theorem** and **code environments**:
  - `Block`
  - `Definition`
  - `Example`
  - `Theorem`
  - `Proof`
  - `Code` (uses the `listings` package via `tcolorbox`)
- **Font** theme with easy to read fonts (extension `beamerfontthemeclassyslides.sty`)
- Optional **header** with progress bar and **footer** with page numbers (extensions `beamerinnerthemeheader.sty` and `beamerinnerthemefooter.sty`)
- Optional **dark** and **light themes** (extensions `beamercolorthemeclassyslideslight.sty` and `beamercolorthemeclassyslidesdark.sty`)
- **Background image** support (extension `beamerinnerthemeclassyslidesbackgrounds.sty`)

## Examples

Sample PDF outputs for various extension configurations are provided in the folder `examples/build`. Extensions are indicated in the file name as follows:

- `euclid--fonts-light.pdf`
  - Default fonts theme and light color theme extensions
  - Produced with `\usetheme[fonts, colors=light]{classylides}`
- `euclid--fonts-dark.pdf`
  - Default fonts theme and dark color theme extensions
  - Produced with `\usetheme[fonts, colors=dark]{classylides}`
- `euclid--fonts-light-header-footer-background.pdf`
  - Default fonts theme, light color theme, header, footer and backgrounds extensions
  - Produced with `\usetheme[fonts, header, footer, backgrounds, colors=light]{classylides}`

The example presentation was adopted from the Euclid presentation example of the [Beamer user manual][2] (Section 3., pp. 21).

[1]: http://tex.stackexchange.com/questions/1137/where-do-i-place-my-own-sty-or-cls-files-to-make-them-available-to-all-my-te
[2]: https://ctan.org/pkg/beamer
