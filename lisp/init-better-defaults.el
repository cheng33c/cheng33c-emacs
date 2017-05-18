(setq ring-bell-function 'ignore)

(global-auto-revert-mode t)

(global-linum-mode t)

(setq make-backup-files nil)

(setq auto-save-default nil)

(delete-selection-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

;; 更快捷的打开最近编辑过的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 自动缩进 C-M-\\
(defun indent-buffer ()
  "Indent the currently visited buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer ()
  "Indent a region if selected, otherwise the whole buffer. "
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indented selected region."))
      (progn
	(indent-buffer)
	(message "Indented buffer.")))))

;; 缩写表,当缩写以空格结束,自动补全
(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; cheng33c
					    ("3cc" "cheng33c")
					    ;; ChenCheng
					    ("2cc" "ChenCheng")
					    ;; Microsoft
					    ("9ms" "Macrosoft")
					    ;; Linux
					    ("5lx" "Linux")
					    ;; Google
					    ("6ge" "Google")
					    ;; Emacs
					    ("5es" "Emacs")
					    ))
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)

(put 'dired-find-alternate-file 'disabled nil)

(require 'dired-x)

(setq dired-dwim-target t)

(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)


;; 高亮括号匹配
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
        (t (save-excursion
             (ignore-errors (backward-up-list))
             (funcall fn)))))

;; 兼容DOS
(defun remove-dos-eol ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))

;; 两空格和四空格切换
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
        (setq js-indent-level (if (= js-indent-level 2) 4 2))
        (setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
             (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
             (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

(global-set-key (kbd "C-c t i") 'my-toggle-web-indent)


(provide 'init-better-defaults)
