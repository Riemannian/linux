(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(global-font-lock-mode t)
(global-set-key "\M-u" 'upcase-region)
(global-set-key "\M-l" 'downcase-region)
(global-set-key "\C-xs" 'save-buffer)
(global-set-key "\C-xv" 'quoted-insert)
(global-set-key "\C-xg" 'goto-line)
(global-set-key "\C-xf" 'search-forward)
(global-set-key "\C-xc" 'compile)
(global-set-key "\C-xt" 'text-mode);
(global-set-key "\C-xr" 'replace-string);
(global-set-key "\C-xK" 'kill-rectangle);
(global-set-key "\C-xW" 'copy-rectangle);
(global-set-key "\C-xY" 'yank-rectangle);
(global-set-key "\C-xa" 'repeat-complex-command);
(global-set-key "\C-xm" 'manual-entry);
(global-set-key "\C-x\C-u" 'shell);
(global-set-key "\C-x\C-r" 'read-only-mode);
(global-set-key "\C-t" 'kill-word);
(global-set-key "\C-p" 'previous-line);
(global-set-key "\C-u" 'backward-word);
(global-set-key "\C-o" 'forward-word);
(global-set-key "\C-h" 'backward-delete-char-untabify);
(global-set-key "\C-x\C-m" 'not-modified);
(global-set-key "\M-e" 'yank); remap paste!
(global-set-key "\M-q" 'set-mark-command);
(setq make-backup-files 'nil);
(setq default-major-mode 'text-mode)
(setq text-mode-hook 'turn-on-auto-fill)
(set-default-font "-misc-fixed-medium-r-normal--15-140-*-*-c-*-*-1")
(setq auto-mode-alist (cons '("\\.cxx$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.hpp$" . c++-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.tex$" . latex-mode) auto-mode-alist))

;;line numbers
(global-linum-mode t);

;; No toolbar nor menu bar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; C-space was no longer setting mark, for some reason


;;set deeper-blue theme
(deftheme deeper-blue
  "")
(custom-theme-set-faces
 'deeper-blue
 '(default ((t (:background "#000000" :foreground "#dcdcdc"))))
 '(cursor ((t (:background "#00ff00" :foreground "#000000"))))
 '(region ((t (:background "#103050"))))
 '(mode-line ((t (:background "#bfbfbf" :foreground "#000000"))))
 '(mode-line-inactive ((t (:background "#545454" :foreground "#000000"))))
 '(fringe ((t (:background "#000000"))))
 '(minibuffer-prompt ((t (:foreground "#98f5ff"))))
 '(font-lock-builtin-face ((t (:foreground "#f08080"))))
 '(font-lock-comment-face ((t (:foreground "#7f7f7f"))))
 '(font-lock-constant-face ((t (:foreground "#a2cd5a"))))
 '(font-lock-function-name-face ((t (:foreground "#daa520"))))
 '(font-lock-keyword-face ((t (:foreground "#00bfff"))))
 '(font-lock-string-face ((t (:foreground "#deb887"))))
 '(font-lock-type-face ((t (:foreground "#98f5ff"))))
 '(font-lock-variable-name-face ((t (:foreground "#b4eeb4"))))
 '(font-lock-warning-face ((t (:foreground "#ff0000" :weight bold))))
 '(isearch ((t (:background "#8b3e2f" :foreground "#ffffff"))))
 '(lazy-highlight ((t (:background "#5f9ea0" :foreground "#ffffff"))))
 '(link ((t (:foreground "#00ffff" :underline t))))
 '(link-visited ((t (:foreground "#ee82ee" :underline t))))
 '(button ((t (:underline t))))
 '(header-line ((t (:background "#e5e5e5" :foreground "#333333")))))
(provide-theme 'deeper-blue)

;; improve scrolling
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Make Emacs use Sicstus interface whenever opening a .pro or .pl file
;; (setq load-path
;;         (cons (expand-file-name "C:/Users/Alexandre/Emacs-24.3/lisp/progmodes")
;;               load-path))
;;      (autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
;;      (autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
;;      (setq prolog-use-sicstus-sd t)
;;      (setq auto-mode-alist (append '(("\\.pro$" . prolog-mode)
;;                                      ("\\.pl$" . prolog-mode))
;;                                auto-mode-alist))

;; Not sure what this does but I think it was algorithmically created when installing Prolog SWI stuff
(put 'upcase-region 'disabled nil)
;; End of algo created during Prolog installation

;; More Prolog SWI
(setq auto-mode-alist
  (cons (cons "\\.pl" 'prolog-mode)
     auto-mode-alist))
;; End of more Prolog SWI

;; cuda c++
(setq auto-mode-alist
  (cons (cons "\\.cu" 'c++-mode)
     auto-mode-alist))

;; python indent to 2 spaces
(add-hook 'python-mode-hook '(lambda () 
 (setq python-indent 2)))

;; php plugin
;; (add-to-list 'load-path "~/.emacs.d/lisp")
;; (load "php-mode.el")


;; gnuplot script mode
;; make sure file is visible to emacs (if needed)
;; (add-to-list 'load-path "/home/alex/Git/gnuplot-mode/gnuplot-mode.el")
(add-to-list 'load-path "~/.emacs.d/lisp/")
;; load the file
(require 'gnuplot-mode)
;; automatically open files ending with .gp or .gnuplot in gnuplot mode
(setq auto-mode-alist 
      (append '(("\\.\\(gp\\|gnuplot\\)$" . gnuplot-mode)) auto-mode-alist)) 


;; TRAMP
(setq tramp-default-method "ssh")


;; Forces the messages to 0, and kills the *Messages* buffer - thus disabling it on startup.
(setq-default message-log-max nil)
(kill-buffer "*Messages*")
