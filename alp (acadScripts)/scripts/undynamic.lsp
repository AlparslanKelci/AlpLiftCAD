(defun c:UnDynamic
    (   /
        _get_item
        _right
        _make_key
        _dynamic->static_block
        _get_locked
        _get_dynamic_inserts
        _main
     	bn_lst
    	adoc
    )
    (defun _get_item ( collection key / item )
        (vl-catch-all-apply
           '(lambda ( ) (setq item (vla-item collection key)))
        )
        item
    )
    (defun _right ( str n / len )
        (if (< n (setq len (strlen str)))
            (substr str (1+ (- len n)))
            str
        )
    )
    (defun _make_key ( collection prefix len / key )
        (   (lambda ( i pad )
                (while
                    (_get_item collection
                        (setq key
                            (strcat prefix
                                (_right
                                    (strcat pad (itoa (setq i (1+ i))))
                                    len
                                )
                            )
                        )
                    )
                )
                key
            )
            0
            (   (lambda ( pad )
                    (while (< (strlen pad) len)
                        (setq pad (strcat "0" pad))
                    )
                    pad
                )
                ""
            )
        )
    )


;;;				Autodesk Lisp Forum            			;;;

      
      (defun _dynamic->static_block ( blocks insert len blst / f bn  bnr)
       (setq bn  (vla-get-effectivename insert))    
        (vla-ConvertToStaticBlock
            insert
            (setq bnr (_make_key blocks (strcat bn " ") len))
        )
        (setq bnr (list bn (vl-string-left-trim (strcat bn " ") bnr) insert))   
        (if (setq f (assoc bn blst))
			 (subst bnr f blst)(cons bnr blst))
	)

;;;				Autodesk Lisp Forum            			;;;

      
    (defun _get_locked ( layers / locked )
        (vlax-for layer layers
            (if (eq :vlax-true (vla-get-lock layer))
                (setq locked (cons layer locked))
            )
        )
        locked
    )
    (defun _get_dynamic_inserts ( blocks / inserts )
        (vlax-for block blocks
            (vlax-for object block
                (if (eq "AcDbBlockReference" (vla-get-objectname object))
                    (if (eq :vlax-true (vla-get-isdynamicblock object))
                        (setq inserts (cons object inserts))
                    )
                )
            )
        )
        inserts
    )
    (defun _main ( document / blocks inserts locked len )
        (if
            (setq inserts
                (_get_dynamic_inserts
                    (setq blocks (vla-get-blocks document))
                )
            )
            (progn
                (foreach layer (setq locked (_get_locked (vla-get-layers document)))
                    (vla-put-lock layer :vlax-false)
                )
                (setq len (strlen (itoa (length inserts))))
                (foreach insert inserts
		(Setq bn_lst
                    (_dynamic->static_block blocks insert len bn_lst))
                      
                )
                (foreach layer locked
                    (vla-put-lock layer :vlax-true)
                )
            )
        )
        (princ)
    )


;;;				Autodesk Lisp Forum            			;;;

	(repeat 4 (vla-purgeall (setq adoc (vla-get-activedocument (vlax-get-acad-object)))))
      
	(_main adoc)
      
	(repeat 4 (vla-purgeall adoc))
	(setq blocks (vla-get-blocks adoc))
	(foreach itm bn_lst
		(vl-catch-all-error-p (vl-catch-all-apply 'vla-put-name 
		          (list (vla-item blocks (Strcat (Car itm)" "(cadr itm))) (Car itm))))
	   )

;;;				Autodesk Lisp Forum            			;;;
          
)	