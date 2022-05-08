(size-indication-mode t)

(defun toot()
  "Post to Mastodon!"

  (interactive)

  (if (<= (buffer-size) 500)
      (send-toot
       (buffer-substring-no-properties (point-min) (point-max))
       )
    (print "MORE THAN 500 CHARS!"))
   )


(defun read-creds ()
  "Read auth tokens from local file"
  (if (file-exists-p "~/.emacstodon")
      (read-creds-from-emacstodon)
    (print "Could not find credentials at ~/.emacstodon")
    )
  )



(defun read-creds-from-emacstodon ()
  "Read auth tokens from ~/.emacstodon"
  (with-temp-buffer
	(insert-file-contents "~/.emacstodon")
	(setq raw-creds (split-string (buffer-string) "\n" t))
	(setq cred-nvps (mapcar (lambda (x) (split-string x "=")) raw-creds))
	(mapcar (lambda (x) (set (intern (car x)) (car (cdr x)))) cred-nvps)))


(defun escape-uri (x)
  (url-hexify-string x))


(defun send-toot(toot-body)
  (read-creds)

  (setq status (concat "status=" (escape-uri toot-body)))

  (setq content-length (number-to-string(length status)))
  (setq headers (concat "Accept: */*\r\n"
			"Host: " MASTODON_HOST "\r\n" 
			"Content-Type: application/x-www-form-urlencoded\r\n"
			"Content-Length: "
			content-length
			"\r\n"
			"Authorization: Bearer "
			ACCESS_TOKEN))

  (setq conn (open-network-stream "toot" nil  MASTODON_HOST 443  :type 'tls))
  (set-process-filter conn 'keep-output)
  (setq body (concat "POST /api/v1/statuses HTTP/1.1\r\n" headers "\r\n\r\n" status))
 
  (process-send-string conn body))


(defun keep-output (process output)
  "Manage and process output anc check status of Toot action."
  (sleep-for 3) ;; async is hard 
  (setq lines (split-string output "\r\n" t))
  (if (string-prefix-p "HTTP/1.1 200 OK" (car lines))
      (message "Tooted!")
    (handle-error lines))
   
  (delete-process conn))



(defun handle-error (lines)
  "Handle error or non-200 condition!"
  (mapcar (lambda (x)
	    
	    (if (string-prefix-p "{\"errors\":" x)
		(message (concat "ERROR: " (car (cdr (reverse (split-string x  "[\"]"))))))
	      (print x)
	       )
	    )
	  lines)
   )
