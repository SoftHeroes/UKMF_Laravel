<?php
function isEmpty($Data)
{
    if ($Data == null)
        return true;
    if (gettype($Data) == 'string') {
        if (trim($Data) == "") {
            return true;
        } elseif (trim($Data) == 'NULL') {
            return true;
        }
    } elseif (gettype($Data) == 'int') {
        return empty($Data);
    }


    return false;
}
