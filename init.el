;; Emacs Customization
;; MC started from scratch

;; 08/12/2014 - initial version
;; 06/02/2015 - cleaned up for mchome
;; 08/27/2019 - disabling track-pad two-finger scroll on ubuntu
;; 09/06/2019 - make ipython the interpreter

;; http://ergoemacs.org/emacs/emacs_package_system.html
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
      t))

;; disable two finger scroll, which my thumb kept triggering on ubuntu
(xterm-mouse-mode)
(global-set-key [mouse-4] 'ignore)
(global-set-key [mouse-5] 'ignore)

;; scroll one line at a time (less "jumpy" than defaults)
;; (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
;; (setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;; (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;; (setq scroll-step 1) ;; keyboard scroll one line at a time


;; display mouse wheel scrolling
;; (setq mouse-wheel-scroll-amount '(0 ((shift) . 1) ((control) . nil)))
;; (setq mouse-wheel-progressive-speed nil)


;; eliminate long "yes" or "no" prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; don't show startup message
(setq inhibit-startup-message t)

;; auto-save behavior
;; http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "~/mchome/temp/emacs-auto-save")))

;; the safest but slowest bet is to always make backups by copying
(setq backup-by-copying t)

;; behavior for old verions
;;   t=silently delete, keep 6 old versions, 2 new version
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; bind RET key to return-and-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; indent after yank region
(dolist (command '(yank yank-pop))
   (eval `(defadvice ,command (after indent-region activate)
            (and (not current-prefix-arg)
                 (member major-mode '(emacs-lisp-mode lisp-mode
                                                      clojure-mode    scheme-mode
                                                      haskell-mode    ruby-mode
                                                      rspec-mode      python-mode
                                                      c-mode          c++-mode
                                                      objc-mode       latex-mode
                                                      plain-tex-mode))
                 (let ((mark-even-if-inactive transient-mark-mode))
                   (indent-region (region-beginning) (region-end) nil))))))

;; python
;; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
(setq py-install-directory "~/.emacs.d/python-mode.el-6.2.0/")
(add-to-list 'load-path py-install-directory)
;;The next line produces an error, so its commented out for now and python isn't used at all
;;(require 'python-mode)

; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
        '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p t)
; don't split windows
(setq py-split-windows-on-execute-p nil)
; try to automagically figure out indentation
(setq py-smart-indentation t)

;; Allow narrow, C-c n n
(put 'narrow-to-region 'disabled nil)

;; make ipython the interpreter
;; 9/6/19
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "--simple-prompt -i")

