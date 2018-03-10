;;hide gui menu
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;basic
(global-linum-mode 1)

;;set package repository
(require 'package)
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa-stable" . "http://elpa.emacs-china.org/melpa-stable/")
			 ("mepla" . "http://elpa.emacs-china.org/melpa/"))
			package-archive-priorities
      			'(("melpa-stable" . 10)
        		("gnu"     	  . 5)
        		("mepla"          . 0)))

(package-initialize)


;;auto load dependency packages if needed
(require 'cl) ;;common lisp package
(defvar my-packages '(
		      company
		      monokai-theme
		      ivy
		      swiper
		      counsel
		      markdown-mode
		      rust-mode
		      racer
		      tide
		      ensime
		      neotree
		      all-the-icons
		      idris-mode
		      haskell-mode
		      elixir-mode
		      alchemist
		      racket-mode
		      ) "Default packages")

(defun my-package-installed-p ()
  (loop for pkg in my-packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (my-package-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg my-packages)
    (when (not (package-installed-p pkg))
    (package-install pkg))))










;;ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t) (setq ivy-count-format "(%d/%d) ")
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library) 
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)






;;recentf
(recentf-mode 1)
(setq recentf-max-menu-items 100)
(setq recentf-max-saved-items 200)
(global-set-key "\C-x\ \C-r" 'counsel-recentf)





;;theme
(load-theme 'monokai t)








;;rust lang
(require 'company)
(require 'rust-mode)
(require 'racer)

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

;;typescript lang
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)






;;Scala Lang
;;(require 'ensmie)
(setq ensime-search-interface 'ivy)

;; For complex scala files
(setq max-lisp-eval-depth 50000)
(setq max-specpdl-size 5000)

(setq ensime-sbt-perform-on-save "compile")




;;neotree
(require 'neotree)


;;elixir alchemist
(require 'elixir-mode)
(require 'alchemist)
(add-to-list 'elixir-mode-hook 'alchemist-mode)
(add-to-list 'elixir-mode-hook 'company-mode)
(setq alchemist-hooks-compile-on-save t)



;;multi frame use neotree: https://github.com/syl20bnr/spacemacs/issues/5682
;;(setq projectile-switch-project-action 'neotree-projectile-action)

(global-set-key [f8] 'neotree-toggle)
;;do not auto refresh tree to current open file
(setq neo-autorefresh nil)
(setq neo-smart-open t)
;;theme
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; ;;org mode
;;设定为自动换行————显示上是多个行，实际是一行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;; racket
(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

(add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
(add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable)

(setq tab-always-indent 'complete)
;;(require 'smartparens-config)
(setq racket-program "/usr/local/bin/racket")

;; ;; xterm with the resource ?.VT100.modifyOtherKeys: 1
;; ;; GNU Emacs >=24.4 sets xterm in this mode and define
;; ;; some of the escape sequences but not all of them.
;; (defun character-apply-modifiers (c &rest modifiers)
;;   "Apply modifiers to the character C.
;; MODIFIERS must be a list of symbols amongst (meta control shift).
;; Return an event vector."
;;   (if (memq 'control modifiers) (setq c (if (or (and (<= ?@ c) (<= c ?_))
;;                                                 (and (<= ?a c) (<= c ?z)))
;;                                             (logand c ?\x1f)
;;                                           (logior (lsh 1 26) c))))
;;   (if (memq 'meta modifiers) (setq c (logior (lsh 1 27) c)))
;;   (if (memq 'shift modifiers) (setq c (logior (lsh 1 25) c)))
;;   (vector c))
;; 
;; ;; custom xterm
;; (defun my-eval-after-load-xterm ()
;;   (when (and (boundp 'xterm-extra-capabilities) (boundp 'xterm-function-map))
;;     (let ((c 32))
;;       (while (<= c 126)
;;         (mapc (lambda (x)
;;                 (define-key xterm-function-map (format (car x) c)
;;                   (apply 'character-apply-modifiers c (cdr x))))
;;               '(;; with ?.VT100.formatOtherKeys: 0
;;                 ("\e\[27;3;%d~" meta)
;;                 ("\e\[27;5;%d~" control)
;;                 ("\e\[27;6;%d~" control shift)
;;                 ("\e\[27;7;%d~" control meta)
;;                 ("\e\[27;8;%d~" control meta shift)
;;                 ;; with ?.VT100.formatOtherKeys: 1
;;                 ("\e\[%d;3~" meta)
;;                 ("\e\[%d;5~" control)
;;                 ("\e\[%d;6~" control shift)
;;                 ("\e\[%d;7~" control meta)
;;                 ("\e\[%d;8~" control meta shift)))
;;         (setq c (1+ c))))))
;; (eval-after-load "xterm" '(my-eval-after-load-xterm))
;; 
;; 
;;(message "init .emacs.d/init.el end.")
;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-remote-files t)
 '(package-selected-packages (quote (idris-mode ensime ivy racer monokai-theme company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
