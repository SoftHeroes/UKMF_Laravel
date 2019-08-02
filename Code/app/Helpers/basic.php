<?php
function isEmpty($Data) {
    if($Data == null)
        return true;
    if(gettype($Data) == 'string' )
    {
        if(trim($Data) == "")
        {
            return true;
        }
    }
    

    return false;
}
?>