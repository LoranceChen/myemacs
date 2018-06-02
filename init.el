;;hide gui menu
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;basic
(global-linum-mode 1)
(setq ring-bell-function 'ignore) ;;forbid ding sound

(message "000000-1")

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

(message "00000000")
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
		      erlang
		      ;;edts
		      elixir-mode
		      alchemist
		      racket-mode
		      sql-indent
		      nyan-mode
		      dracula-theme
		      spacemacs-theme
		      rebecca-theme
		      zenburn-theme
		      doom-themes
		      material-theme
		      moe-theme
		      solarized-theme
		      ace-window
		      hydra
		      ;flycheck
		      ;flycheck-tip
		      ;company-distel
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



(message "00001")






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
;;;;;;; overview ;;;;;;;;;
;; doom-vibrant ;;淡青色调，清凉的干净
;;material ;;藏青色调，冷色，安稳，轻微的drawn
;;monokai ;;沉稳中透露出热情
;;rebecca ;;深沉紫，色彩层次不分明
;;solarized-drak ;; 色彩整体偏低沉，稳重，有点土
;;spacemacs-dark ;; 层次区分挺好，就是有点陈旧的图书馆的书，适合40岁以后的中年大叔使用
;;zenburn ;; 军绿色调，回到了80年代
;;  misterioso ;; 就像一个刚毕业的研究生，有思想的沉淀，也有点对新生活的追求
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(load-theme 'spacemacs-dark t) ;;auto complete font is ugly. be used to load font bold at first
(load-theme 'monokai t) ;; keyword is red
;;(load-theme 'dracula t) ;; keyword is white
;;(load-theme 'zenburn t)
;;(load-theme 'rebecca t) ;; auto complete is to dark 
;;(load-theme 'solarized-dark t) ;; color to drawn(憔悴的)
;;(load-theme 'material t) ;;don't like yellow keyword
;;(load-theme 'leuven t)
;;(load-theme 'doom-vibrant t)

;;(load-theme 'misterioso t) ;;对elixir支持不够完善，auto-complete。。。醉了。 todo,代码补全的提示框的颜色搭配需要提个意见


;; common
;; company mode for all file
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)



;;rust lang
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

(setq alchemist-goto-erlang-source-dir "/Users/lorancechen/soft/otp-master/")
(setq alchemist-goto-elixir-source-dir "/Users/lorancechen/version_control_project/_open_source/elixir/")


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
;;(setq racket-program "/usr/local/bin/racket")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-remote-files t)
 '(custom-safe-themes
   (quote
    ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "bfdcbf0d33f3376a956707e746d10f3ef2d8d9caa1c214361c9c08f00a1c8409" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "93f9654f91d31e9a9ec6ea2fcffcfcab38353a9588673f2b750e591f704cd633" "4e21fb654406f11ab2a628c47c1cbe53bab645d32f2c807ee2295436f09103c6" "a866134130e4393c0cad0b4f1a5b0dd580584d9cf921617eee3fd54b6f09ac37" "0846e3b976425f142137352e87dd6ac1c0a1980bb70f81bfcf4a54177f1ab495" "b5ecb5523d1a1e119dfed036e7921b4ba00ef95ac408b51d0cd1ca74870aeb14" "53d1bb57dadafbdebb5fbd1a57c2d53d2b4db617f3e0e05849e78a4f78df3a1b" "7666b079fc1493b74c1f0c5e6857f3cf0389696f2d9b8791c892c696ab4a9b64" "2a1b4531f353ec68f2afd51b396375ac2547c078d035f51242ba907ad8ca19da" "b97a01622103266c1a26a032567e02d920b2c697ff69d40b7d9956821ab666cc" "f09acf642ecd837d2691ba05c6f3e1d496f7930b45bf41903e7b37ea6579aa79" "a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "2af26301bded15f5f9111d3a161b6bfb3f4b93ec34ffa95e42815396da9cb560" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages (quote (idris-mode ensime ivy racer monokai-theme company))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 257)) (:foreground "#F8F8F2" :background "#272822")) (((class color) (min-colors 89)) (:foreground "#F5F5F5" :background "#1B1E1C")))))

;; load file
(load "~/.emacs.d/lib/display")
(load "~/.emacs.d/lib/elixir")
(load "~/.emacs.d/lib/xml")
(load "~/.emacs.d/lib/others")

;; custom file
;;(setq custom-file "~/.emacs.d/lib/custom-file")
;;(load custom-file)
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

(message "load end")
