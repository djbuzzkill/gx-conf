
;;---------------------------------------------------------------------------------------
;;
;; ಠ_ಠ
;;
;; ;; init.el:
;; ;; quit putting customize shit in this file
;; (setq custom-file (locate-user-emacs-file "custom_vars.el"))
;; (load custom-file 'noerror 'nomessage)
;;
;;
;; ;; 
;; (let ((init-file "config.el"))
;;   (load (format "%s/owenslake/gx-conf/emacs/%s" (getenv "HOME") init-file)))
;;
;; (put 'upcase-region 'disabled nil)
;;
;;---------------------------------------------------------------------------------------


;; my el
(let ((my-funcs "gx.el"))
  (load (format "%s/owenslake/gx-conf/emacs/%s" (getenv "HOME") my-funcs)))

(setq inhibit-startup-message t)
(setq use-dialog-box nil)
(setq visible-bell nil)
(setq truncate-lines nil)
;;
(global-font-lock-mode t)
(show-paren-mode 1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode 1)
(transient-mark-mode 1)
;;
(recentf-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)
(global-display-line-numbers-mode t)
(set-fringe-mode 10)


;; quit putting customize shit in this file
(setq custom-file (locate-user-emacs-file "custom_vars.el"))
(load custom-file 'noerror 'nomessage)

;;
(require 'package)
;; package places
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))
;;
(package-initialize)



(require 'use-package)


;;
(unless package-archive-contents
  (package-refresh-contents))

;; initialize use-package on non linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))



;;	 
(setq use-package-always-ensure t)

;;; https://github.com/Alexander-Miller/treemacs/issues/164
(with-eval-after-load 'treemacs

  (defun treemacs-ignore-example (filename absolute-path)
    (or (string-match "/Blender" absolute-path)
	(string-match "/Bullet_platform" absolute-path)
	(string-match "/OpenGL_system" absolute-path)
	(string-match "/Rn_" absolute-path)
	(string-match "/ninjabuild" absolute-path)
	(string-match "/Debug" absolute-path)
	(string-match "/Release" absolute-path)

	(string-match "/shader" absolute-path)
	(string-match "/spux" absolute-path)
	(string-match "/spux_SDL2" absolute-path)
	(string-match "/res" absolute-path)
	(string-match "/SDL2_platform" absolute-path)
	(string-match "/Hx" absolute-path)
	(string-match "/Ma_" absolute-path)
	(string-match "Terrain_renderer" absolute-path)
	(string-match "Ma_" absolute-path)

	(string-match "/test_Mars" absolute-path)
	(string-match "/data" absolute-path)
	(string-match "/Charon" absolute-path)
	(string-match "/Dx" absolute-path)))

  (add-to-list 'treemacs-ignored-file-predicates #'treemacs-ignore-example))



; no line numbers for these buffers
(dolist (mode '(org-mode-hook
		term-mode-hook
                shell-mode-hook
		treemacs-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda  () (display-line-numbers-mode 0))))
  

;;
;;
(use-package command-log-mode)

;;
;; better mode buffer functionality
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 ("C-l" . ivy-alt-done)
	 ("C-j" . ivy-next-line)
	 ("C-k" . ivy-previous-line)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-previous-line)
	 ("C-l" . ivy-done)
	 ("C-d" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-previous-line)
	 ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
	  

;; remember to "install fonts"
(use-package all-the-icons)

;;
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

;; (define-key emacs-lisp-mode-map (kbd "C-d u") 'counsel-load-theme)

;; DOOM ;;
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 16)))

;; 
(use-package doom-themes
  :init (load-theme 'doom-tokyo-night t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; wtf is this for
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config (setq which-key-idle-delay 0.3))


;; 
(use-package ivy-rich
  :init (ivy-rich-mode 1))


;; 
(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . 'counsel-minibuffer-history)))


;
(use-package helpful
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-varialbe] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

;; 
(use-package general
  :config
  (general-create-definer gx/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")
  (gx/leader-keys
   "t"  '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")

   "b"  '(:ignore b :which-key "buffer operations")
   "bb" '(counsel-ibuffer :which-key "switch buffer")

   "f"  '(:ignore f :which-key "file operations")
   "fo" '(find-file-existing :whitch-key "open an existing file")
   "fp" '(find-file-at-point :which-key "open file at point")
   "fr" '(recentf-open-files :which-key "open recent file list")
   "fm" '(recentf-open-more-files :which-key "open more recent files")
   ))


;; vi in emacs
;; (use-package evil
;;   :init (setq evil-want-integration nil)
;;         (setq evil-want-keybinding nil)
;;         (setq evil-want-C-u-scroll t)
;; 	(setq evil-want-C-i-jump nil)
;;   :config
;;   (evil-mode 1)
;;   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
;;   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
;;   (define-key evil-insert-state-map (kbd "C-d") 'evil-delete-char) 


;;   (evil-define-key '(normal visual) evil-normal-state-map (kbd "i") nil)
;;   (evil-define-key '(normal visual) evil-normal-state-map (kbd "I") nil)
;;   (evil-define-key '(normal visual) evil-normal-state-map (kbd "a") nil)
;;   (evil-define-key '(normal visual) evil-normal-state-map (kbd "A") nil)

  
;;   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;;   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

;;   (evil-set-initial-state '*ielm* 'normal)
;;   (evil-set-initial-state 'messages-buffer-mode 'normal)
;;   (evil-set-initial-state 'dashboard-mode 'normal))

;;  (evil-define-key '(mormal visual) evil-normal-state-map (kbd "<home>") 'eshell-bol)

;; 
;; (use-package evil-collection
;;   :after evil
;;   :config (evil-collection-init))
;; 	  ;;

;; comment/uncomment code
(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))


;;
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom (dired-listing-switches "-agho --group-directories-first")
;; :config (evil-collection-define-key 'normal 'dired-mode-map  "h" 'dired-up-directory  "l" 'dired-find-file)


  )



;; for keybinding stuff
(use-package hydra)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))
;; wah :w

(gx/leader-keys
 "ts" '(hydra-text-scale/body :which-key "scale-text"))
  
(use-package forge)



(defun gx/org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  (setq evil-auto-indent nil))


;;
(use-package org
;; :hook (org-mode . 
  :config (setq org-ellipsis " ▾"))



(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))
;; Α α, Β β, Γ γ, Δ δ, Ε ε, Ζ ζ, Η η, Θ θ, Ι ι, Κ κ, Λ λ, Μ μ, Ν ν, Ξ ξ, Ο ο, Π π, Ρ ρ, Σ σ/ς, Τ τ, Υ υ, Φ φ, Χ χ, Ψ ψ, Ω ω.

(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  (add-hook 'rustic-mode-hook 'rk/rustic-mode-hook))

(defun rk/rustic-mode-hook ()
  ""
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
  (add-hook 'before-save-hook 'lsp-format-buffer nil t))



(use-package eglot
  :init (eglot-ensure)
  :config (add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'c++-mode-hook 'eglot-ensure)
  )


(defun gx/lsp-mode-setup ()
  ""
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . gx/lsp-mode-setup)
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  :custom
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.5)
  
  :init (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-enable-which-key-integration t)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))


;; 
(use-package lsp-ui
  :commands lsp-ui-mode
  :custom
  (lsp-ui-doc-position 'bottom)
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable nil))
;;
(use-package lsp-treemacs
  :after lsp)

;;
(use-package dap-mode)

;; https://github.com/emacs-lsp/dap-mode/issues/442
(require 'dap-gdb-lldb)

;; ?? is this needed ??
;; (require 'dap-node)

;;
(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind
  (:map company-active-map
	("<tab>" . company-complete-selection))
  (:map lsp-mode-map
	("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 2)
  (company-idle-delay 0.5))


;;(use-package company-box
;; :hook (company-mode . company-box-mode))


;;
(use-package lsp-ivy)




;; (add-to-list 'auto-mode-alist '("\\.h\\'" . cc-mode))

;;
(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom (projectile-completion-system 'ivy)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (setq projectile-project-search-path '(("~/owenslake" . 2) ("~/saltonsea" . 2)))
  (setq projectile-switch-project-action #'projectile-dired))

;; 

;;
;; (use-package treemacs-projectile


;;   
(use-package counsel-projectile
  :config (counsel-projectile-mode))

;;
(use-package magit
  :commands (magit-status magit-get-currennt-branch)
;;  :init
;;  (bind-key "C-x g" 'magit-status)
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;;
;; evil collection
 ;; (use-package evil-collection
 ;; :after magit)

;;
;;
(use-package term
  :config
  (setq explicit-shell-filename "bash")
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))
  
;;
(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :commands vterm

  :config
  (setq vterm-max-scrollback 10000)
  ;; vterm specific
  (define-key vterm-mode-map (kbd "C-M-j") 'counsel-switch-buffer)
  (define-key vterm-mode-map (kbd "C-n")   'next-buffer)
  (define-key vterm-mode-map (kbd "C-p")   'previous-buffer))



;;
(use-package eshell-git-prompt)



(defun gx/configure-eshell ()
  (add-hook 'eshell-pre-command-hook 'eshell-truncate-buffer)

  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'counsel-esh-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-maps)

  (setq eshell-history-size (* 10 1024)
	eshell-buffer-maximum-lines  (* 10 1024)
	eshell-hist-ignoredupes t
	eshell-scroll-to-bottom-on-input t))


;;

(use-package eshell
  :hook (eshell-first-time-mode . 'gx/configure-eshell)
  :config (eshell-git-prompt-use-theme 'robbyrussell))




;;(use-package cc-mode
;;  :mode "\\.cpp\\'")

;;
(use-package python-mode
  :ensure t
  :hook (python-mode . lsp-deferred)
  :custom
  (python-shell-interpreter "python3")
  (dap-python-executable "python3")
  (dap-python-debugger 'debugpy)
  :config
  (require 'dap-python))

;;
(use-package pyvenv
  :config (pyvenv-mode 1))

;; 
(use-package flycheck
  :ensure 
  :init (global-flycheck-mode t))


;;

;;(use-package tabbar
;;  :init (tabbar-mode 1))
  

;;
;(require 'slime)
;; (use-package slime
;;         (slime-setup)
;;   :config (slime-setup '(slime-fancy)))
;; (use-package sly
;;   :init (setq inferior-lisp-program "/usr/bin/sbcl")
;;   :config (setq lisp-mode-hook 'sly-editing-mode))  

(setq c-mode-common-hook
      (lambda()
	(setq truncate-lines 1)
	(lsp)
 	(setq indent-tabs-mode nil)))
 
;; (setq flycheck-cppcheck-include-path
;;       '("/home/djbuzzkill/owenslake/gx/"
;; 	"/home/djbuzzkill/owenslake/gx/ffm/"
;; 	"/home/djbuzzkill/owenslake/gx/aframe/"
;; 	"/home/djbuzzkill/owenslake/gx/bmx/"))

;;
(eval-after-load 'sly `(define-key sly-prefix-map (kbd "M-h") 'sly-documentation-lookup))

;; 
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-<tab>")  'other-window)

(global-set-key (kbd "M-m")      'set-mark-command)

(global-set-key (kbd "M-<up>")   'scroll-down-line)
(global-set-key (kbd "M-<down>") 'scroll-up-line)

(global-set-key (kbd "C-o")      'find-file-existing) 
(global-set-key (kbd "C-<tab>")   'next-multiframe-window)


(global-set-key (kbd "C-x C-r") 'recentf-open-files) 
(global-set-key (kbd "C-x C-m") 'recentf-open-more-files) 


(global-set-key (kbd "C-<backspace>") 'gx/backward-kill-word) 
(global-set-key (kbd "M-d") 'gx/kill-word) 



(global-set-key (kbd "C-j") 'forward-line)      ;; was electric-newline..'mebe indent'
(global-set-key (kbd "C-k") 'previous-line)      ;; was kill-line

;;(global-set-key (kbd "C-j") 'forward-line) ;; was electric-newline..'mebe indent'
(global-set-key (kbd "M-k") 'kill-line)      ;; was kill-line





;; die M-z

;; wtf C-[ 
;;(global-set-key (kbd "C-[")    nil)
;; (global-set-key (kbd "C-]")    nil)

;;(global-set-key (kbd "C-,")   'previous-buffer)
;; C-. has a problem 
;;(glboal-set-key (kbd "C-.")   'next-buffer)


(global-set-key (kbd "C-n")    'previous-buffer)
(global-set-key (kbd "C-p")    'next-buffer)

(global-set-key (kbd "M-n")    'previous-line)
(global-set-key (kbd "M-p")    'forward-line)

(global-set-key (kbd "C-q")    'save-buffers-kill-terminal)
(global-set-key (kbd "M-q")    nil)

(global-set-key (kbd "C->")    'previous-multiframe-window)
(global-set-key (kbd "C-<")    'next-multiframe-window)

(global-set-key (kbd "C-{")    'beginning-of-defun)
(global-set-key (kbd "C-}")    'end-of-defun)
(global-set-key (kbd "<menu>") nil)

(global-set-key (kbd "C-<up>")   'gx/scroll-view-backward-line)    
(global-set-key (kbd "C-<down>") 'gx/scroll-view-forward-line)

(global-set-key (kbd "M-f")    'forward-to-word)
(global-set-key (kbd "M-b")    'backward-to-word)



(global-set-key (kbd "<menu>") nil)


(global-unset-key (kbd "C-x C-z")) ;; 'forward-line) ;; swap with C-j
(global-unset-key (kbd "C-z"))     ;; 'previous-line);; swap with C-k

(global-unset-key (kbd "C-<shift> <up>"))

;;(find-file  "~/hello.org")

;; (find-file  "~/hello.lisp")
;; (find-file  "~/owenslake/gx-conf/emacs/config.el")
;; (find-file  "~/.config/awesome/rc.lua")
;;
;; (bookmark-load "~/.emacs.d/bookmarks")
(bookmark-load "~/.emacs.d/gx.bookmarks")
