;; company
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)

;; backup
(setq make-backup-files nil)

;;ace-window and hydraa=
(global-set-key (kbd "M-o") 'ace-window)

(defhydra hydra-zoom (global-map "M-p")
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out"))

(require 'ace-window)
(require 'hydra)
;;          :ensure t
 ;         :defer 1
 ;         :config
          (set-face-attribute 'aw-leading-char-face nil :foreground "deep sky blue" :weight 'bold :height 3.0)
          (set-face-attribute 'aw-mode-line-face nil :inherit 'mode-line-buffer-id :foreground "lawn green")
          (setq aw-keys   '(?a ?s ?d ?f ?j ?k ?l)
                aw-dispatch-always t
                aw-dispatch-alist
                '((?x aw-delete-window     "Ace - Delete Window")
                  (?c aw-swap-window       "Ace - Swap Window")
                  (?n aw-flip-window)
                  (?v aw-split-window-vert "Ace - Split Vert Window")
                  (?h aw-split-window-horz "Ace - Split Horz Window")
                  (?m delete-other-windows "Ace - Maximize Window")
                  (?g delete-other-windows)
                  (?b balance-windows)
                  (?u winner-undo)
                  (?r winner-redo)))

          ;(when (package-installed-p 'hydra)
            (defhydra hydra-window-size (:color red)
              "Windows size"
              ("h" shrink-window-horizontally "shrink horizontal")
              ("j" shrink-window "shrink vertical")
              ("k" enlarge-window "enlarge vertical")
              ("l" enlarge-window-horizontally "enlarge horizontal"))
            (defhydra hydra-window-frame (:color red)
              "Frame"
              ("f" make-frame "new frame")
              ("x" delete-frame "delete frame"))
            (defhydra hydra-window-scroll (:color red)
              "Scroll other window"
              ("n" joe-scroll-other-window "scroll")
              ("p" joe-scroll-other-window-down "scroll down"))
            (add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)
            (add-to-list 'aw-dispatch-alist '(?o hydra-window-scroll/body) t)
(add-to-list 'aw-dispatch-alist '(?\; hydra-window-frame/body) t)

;)
(ace-window-display-mode t)
;;)

;;window-resize
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-M-<up>") 'enlarge-window)



;; xml
(setq auto-mode-alist (cons '("\\.xml$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xsl$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xhtml$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.page$" . nxml-mode) auto-mode-alist))

(autoload 'xml-mode "nxml" "XML editing mode" t)

(eval-after-load 'rng-loc
  '(add-to-list 'rng-schema-locating-files "~/.schema/schemas.xml"))

(global-set-key [C-return] 'completion-at-point)


(add-to-list 'auto-mode-alist
	     (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
		   'nxml-mode))

(unify-8859-on-decoding-mode)

(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
	    magic-mode-alist))
(fset 'xml-mode 'nxml-mode)



;; back file
(setq make-backup-files nil)
