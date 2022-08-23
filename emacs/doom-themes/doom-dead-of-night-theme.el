;;; doom-dead-of-night-theme.el --- inspired by Atom's City Lights theme -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: March 8, 2018 (7d6ff334c45a)
;; Author: fuxialexander <https://github.com/fuxialexander>
;; Maintainer:
;; Source: https://citylights.xyz
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-dead-of-night-theme nil
  "Options for the `doom-dead-of-night' theme."
  :group 'doom-themes)

(defcustom doom-dead-of-night-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-dead-of-night-theme
  :type 'boolean)

(defcustom doom-dead-of-night-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-dead-of-night-theme
  :type 'boolean)

(defcustom doom-dead-of-night-comment-bg doom-dead-of-night-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-dead-of-night-theme
  :type 'boolean)

(defcustom doom-dead-of-night-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-dead-of-night-theme
  :type '(choice integer boolean))


;;
;;; Theme definition
(def-doom-theme doom-dead-of-night
  "embrace the void"

  ;; name        default   256       16
  ((bg         '("#000a10" nil       nil            ))
   (bg-alt     '("#0a101a" nil       nil            ))
   (base0      '("#0f141c" "black"   "black"        ))
   (base1      '("#121820" "#111122" "brightblack"  ))
   (base2      '("#1a1c26" "#222222" "brightblack"  ))
   (base3      '("#1f2230" "#223333" "brightblack"  ))
   (base4      '("#242a38" "#334455" "brightblack"  ))
   (base5      '("#2a2f40" "#556677" "brightblack"  ))
   (base6      '("#343648" "#668899" "brightblack"  ))
   (base7      '("#3f3c50" "#77AABB" "brightblack"  ))
   (base8      '("#424458" "#99AABB" "white"        ))

   (fg-alt     '("#3070A0" "#7788AA" "brightwhite"  ))
   (fg         '("#80C0F0" "#AABBCC" "white"        ))

   (grey        '("#556666" "#ff6655" "red"          ))
   (dark-grey   '("#10262a" "#ff6655" "red"          ))

   (red         '("#f05468" "#ff6655" "red"          ))
   (orange      '("#e09048" "#dd8844" "brightred"    ))
   (green       '("#8BD49C" "#99bb66" "green"        ))
   (teal        '("#33CED8" "#33CCDD" "brightgreen"  ))
   (yellow      '("#ebf088" "#EEBB88" "yellow"       ))

   (bright-blue '("#20a0ff" "#5599FF" "blue"         ))
   (blue        '("#1690f0" "#55CCFF" "brightblue"   ))
   (dark-blue   '("#0a8Cee" "#7788AA" "blue"         ))

   (magenta     '("#FF66FF" "#EE7788" "magenta"      ))
   (violet      '("#B62D65" "#BB2266" "brightmagenta"))
   (cyan        '("#22ddff" "#77EEEE" "brightcyan"   ))
   (dark-cyan   '("#00949a" "#008899" "cyan"   ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.4))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if doom-dead-of-night-brighter-comments dark-cyan grey))
   (doc-comments   (doom-lighten (if doom-dead-of-night-brighter-comments dark-cyan grey) 0.25))
   (constants      bright-blue)
   (functions      cyan)
   (keywords       blue)
   (methods        cyan)
   (operators      red)
   (type           blue)
   (strings        magenta)
   (variables      dark-blue)
   (numbers        magenta)
   (region         base6)
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-dead-of-night-brighter-modeline)
   (-modeline-pad
    (when doom-dead-of-night-padded-modeline
      (if (integerp doom-dead-of-night-padded-modeline) doom-dead-of-night-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        base3
      `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l modeline-bg)
   (modeline-bg-inactive   `(,(car bg) ,@(cdr base1)))
   (modeline-bg-inactive-l (doom-darken bg 0.1)))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground grey :background dark-grey)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override) :background (if doom-dead-of-night-comment-bg (doom-lighten bg 0.05)))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))

   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   ;;;; company
   (company-tooltip-selection     :background base3)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; magit
   (magit-diff-hunk-heading-highlight :foreground fg :background base4 :weight 'bold)
   (magit-diff-hunk-heading :foreground fg-alt :background base3 :weight 'normal)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-url-face    :foreground teal :weight 'normal)
   (markdown-reference-face :foreground base6)
   ((markdown-bold-face &override)   :foreground fg)
   ((markdown-italic-face &override) :foreground fg-alt)
   ;;;; outline <built-in>
   ((outline-1 &override) :foreground blue)
   ((outline-2 &override) :foreground green)
   ((outline-3 &override) :foreground teal)
   ((outline-4 &override) :foreground (doom-darken blue 0.2))
   ((outline-5 &override) :foreground (doom-darken green 0.2))
   ((outline-6 &override) :foreground (doom-darken teal 0.2))
   ((outline-7 &override) :foreground (doom-darken blue 0.4))
   ((outline-8 &override) :foreground (doom-darken green 0.4))
   ;;;; org <built-in>
   ((org-block &override) :background base2)
   ((org-block-begin-line &override) :background base2)
   (org-hide :foreground hidden)
   ;;;; ivy
   (ivy-minibuffer-match-face-2 :foreground blue :weight 'bold)
   ;;;; js2-mode
   (js2-object-property :foreground dark-blue)
   (js2-object-property-access :foreground dark-cyan)
   ;;;; rjsx-mode
   (rjsx-tag :foreground dark-cyan)
   (rjsx-attr :foreground cyan :slant 'italic :weight 'medium)
   ;;;; solaire-mode
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l))))

  ;;;; Base theme variable overrides-
  ()
  )

;;; doom-dead-of-night-theme.el ends here
