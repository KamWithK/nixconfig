(setq custom-file (make-temp-file "emacs-custom-"))
(setq backup-directory-alist '((".*" . "~/.EmacsBackups")))

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update nil)
  (auto-package-update-hide-results t)
  (auto-package-update-delete-old-versions t)
  :config
  (auto-package-update-maybe))

(use-package org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode))

(setq org-src-preserve-indentation t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(setq display-line-numbers 'relative)
(setq display-line-numbers-type 'relative)

(set-face-attribute 'default nil
		    :font "Hack Nerd Font"
		    :height 140
		    :weight 'bold)
(set-face-attribute 'variable-pitch nil
		    :font "Hack Nerd Font"
		    :height 140
		    :weight 'bold)
(set-face-attribute 'fixed-pitch nil
		    :font "Hack Nerd Font"
		    :height 140
		    :weight 'bold)

(use-package doom-modeline
  :init (doom-modeline-mode t)
  :custom
  (doom-modeline-height 50)
  (doom-modeline-bar-width 5)
  (doom-modeline-persp-name t)
  (doom-modeline-persp-icon t))

(use-package neotree
  :custom
  (neo-smart-open t)
  (neo-show-hidden-files t))
(global-set-key [f2] 'neotree-toggle)
(neotree-dir "~/")
(neotree-hide)

(use-package dashboard
  :config (dashboard-setup-startup-hook)
  :custom
  (dashboard-center-content t)
  (dashboard-vertically-center-content t)
  (dashboard-startup-banner 'logo)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-items '(
		     (recents . 5)
		     (projects . 5)
		     (agenda . 10))
		   )
  :hook (after-init . dashboard-refresh-buffer)
  :hook (server-after-make-frame . dashboard-refresh-buffer))

(use-package evil
  :init
  (setq evil-want-keybinding nil evil-undo-system 'undo-redo)
  :config (evil-mode t))
(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-evil-setup)
  (general-create-definer kam/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "M-SPC")

  (kam/leader-keys
    "." '(find-file :wk "Find file")
    "SPC" '(project-find-file :wk "Find file in project")
    "~" '(consult-outline :wk "Found outline")
    "," '(switch-to-buffer :wk "Switch buffer")
    "w" '(evil-window-map :wk "Window")
    "`" '(evil-switch-to-windows-last-buffer :wk "Switch to last buffer")
    "/" '(project-find-regexp :wk "Search project")
    "a" '(org-agenda :wk "Agenda")
    )

  (kam/leader-keys
    "b" '(:ignore t :wk "Buffers & Bookmarks")
    "b [" '(previous-buffer :wk "Previous buffer")
    "b ]" '(next-buffer :wk "Next buffer")
    "b b" '(switch-to-buffer :wk "Switch to buffer")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
    "b d" '(kill-current-buffer :wk "Kill current buffer")
    "b i" '(consult-buffer :wk "Ibuffer")
    "b k" '(kill-current-buffer :wk "Kill current buffer")
    "b K" '(kill-some-buffers :wk "Kill all buffers")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
    "b R" '(rename-buffer :wk "Rename buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b S" '(save-some-buffers :wk "Save multiple buffers")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b M" '(bookmark-delete :wk "Delete bookmark")
    "b l" '(list-bookmarks :wk "List bookmarks")
    )

  (kam/leader-keys
    "p" '(:ignore t :wk "Project")
    "p p" '(project-switch-project :wk "Switch project")
    "p d" '(project-forget-project :wk "Forget project")
    "p D" '(project-remember-projects-under :wk "Index projects under directory")
    "p f" '(project-find-file :wk "Find file in project")
    "p o" '(find-sibling-file :wk "Find sibling file")
    "p k" '(project-kill-buffers :wk "Kill project buffers")
    )

  (kam/leader-keys
    "c" '(:ignore t :wk "Code")
    "c a" '(eglot-code-actions :wk "LSP Execute Code Action")
    "c r" '(eglot-rename :wk "LSP Rename")
    "c j" '(eglot-find-declaration :wk "LSP Find Declaration")
    "c f" '(apheleia-format-buffer :wk "Format")
    )

  (kam/leader-keys
    "m" '(:ignore t :wk "Mark")
    "m t" '(org-todo :wk "Todo")
    "m s" '(org-schedule :wk "Schedule")
    "m d" '(org-deadline :wk "Deadline")
    )
  )

(use-package yasnippet :config (yas-global-mode t))
(use-package yasnippet-snippets :after yasnippet)

(use-package which-key
  :config
  (which-key-mode))

(use-package vertico
  :custom
  (vertico-cycle t) 
  :init
  (vertico-mode))
(use-package vertico-posframe
  :custom
  (vertico-posframe-mode t)
  (vertico-posframe-border-width 10)
  :hook
  (after-init . (lambda ()
		  (set-face-attribute 'vertico-posframe-border nil :background (face-attribute 'border :background))
		  ))
  )

(use-package marginalia
  :bind (:map minibuffer-local-map
	      ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package savehist
  :init
  (savehist-mode))

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  (corfu-quit-no-match t)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

(electric-pair-mode t)
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package apheleia
  :config
  (apheleia-global-mode +1))

(use-package project
  :custom (project-vc-extra-root-markers '(".project"))
  )

(use-package sudo-edit)

(setq org-directory (expand-file-name "~/org/"))
(setq org-agenda-files `(,org-directory))
(setq org-hide-emphasis-markers t)
;; (add-hook 'org-mode-hook 'org-indent-mode)

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 2.0))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.5))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.4))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.2))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 )

(setq org-agenda-remove-tags t)
(setq org-agenda-start-day "+0d")
(setq org-agenda-span 3)
(setq org-agenda-prefix-format '(
 				 (agenda . "  %i %?-12t% s")
 				 (todo . " %i %-12:c")
 				 (tags . " %i %-12:c")
 				 (search . "%i %-12:c")
 				 ))

(use-package org-modern
  :after org
  :hook (org-mode . global-org-modern-mode)
  :custom
  (org-modern-star 'replace)
  (org-modern-priority '(
			 (?A . "")
			 (?B . "")
			 (?C . "")
			 ))
  ;; (org-modern-priority-faces '(
  ;; 			       (?A :background "red" :foreground "red")
  ;; 			       (?B :background "blue" :foreground "blue")
  ;; 			       (?C :background "green" :foreground "green")
  ;; 			       ))
  )
(modify-all-frames-parameters
 '((internal-border-width . 10)))

(use-package org-super-agenda
  :load-path "~/repos/org-super-agenda/"
  :ensure t
  :custom
  (org-super-agenda-groups '(
 			     (:name "  Overdue" :scheduled past :order 1)
 			     (:name "  Health" :tag "health" :order 2)
 			     (:name "  Life" :tag "life" :order 3)
 			     (:name "  Technology" :tag "technology" :order 4)
 			     (:name "  Guitar" :tag "guitar" :order 4)
 			     (:name "  Today" :date today :scheduled today :order 5)
 			     ))
  (org-super-agenda-mode t)
  (org-super-agenda-final-group-separator "\n\n\n")
  :config
  (set-face-attribute 'org-super-agenda-header nil :box t :height 1.05)
  )

(use-package markdown-mode)
(use-package nix-mode)
(use-package typescript-ts-mode)
(use-package typescript-mode) ;; Outdated, but needed for svelte-mode
(use-package svelte-mode)
(use-package rust-ts-mode)
(use-package go-ts-mode)

(use-package eglot
  :after yasnippet
  :config
  (add-to-list 'eglot-server-programs '(nix-mode . ("nil")))
  (add-to-list 'eglot-server-programs '(svelte-mode . ("svelteserver" "--stdio")))
  :hook (prog-mode . eglot-ensure)
  )

(use-package xref)

(use-package consult
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref))
(setq read-file-name-function #'consult-find-file-with-preview)

(defun consult-find-file-with-preview (prompt &optional dir default mustmatch initial pred)
  (interactive)
  (let ((default-directory (or dir default-directory))
        (minibuffer-completing-file-name t))
    (consult--read #'read-file-name-internal :state (consult--file-preview)
                   :prompt prompt
                   :initial initial
                   :require-match mustmatch
                   :predicate pred)))

;; (require 'keymap) ;; keymap-substitute requires emacs version 29.1?
;; (require 'cl-seq)

;; (keymap-substitute project-prefix-map #'project-find-regexp #'consult-ripgrep)
;; (cl-nsubstitute-if
;;  '(consult-ripgrep "Find regexp")
;;  (pcase-lambda (`(,cmd _)) (eq cmd #'project-find-regexp))
;;  project-switch-commands)
;; Example configuration for Consult

(use-package embark)
(use-package embark-consult :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package eldoc :init (global-eldoc-mode))

(use-package flymake :hook (prog-mode . flymake-mode))
