;;;				PURGEALL (with No user interaction)           			;;;
(defun c:PURGEALL ()
(setq thisdrawing (vla-get-activedocument
                    (vlax-get-acad-object)))

(vla-PurgeAll thisdrawing))

(defun c:xploadable ()
(vl-load-com)
(vlax-for b (vla-get-Blocks
(vla-get-ActiveDocument (vlax-get-acad-object))
)
(or (wcmatch (vla-get-Name b) "`**_Space*")
(vla-put-explodable b :vlax-true)
)
)
(princ)
)
(c:xploadable)


;;;				BURSTALL (ALL BLOCKS)           			;;;
(defun c:BURSTALL (/ AllBlocks)
(setq AllBlocks (ssget "X" (list (cons 0 "INSERT"))))
 (command "_.select"  AllBlocks "")
(c:BURST))


;;;				DELETE WIPEOUTS           			;;;
(defun c:delWipeouts (/ b)
 (setvar "pickstyle" 0)
 (setq b (ssget "x" '((0 . "wipeout"))))
 (command "._erase" b ""))

(c:PURGEALL)
(c:BURSTALL)
(c:PURGEALL)
(c:BURSTALL)
(c:delWipeouts)