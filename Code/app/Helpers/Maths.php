<?php
function millisecsBetween($dateOne, $dateTwo, $abs = true) {
    

    $startTime = new DateTime($dateOne);
    $endDate = new DateTime($dateTwo);

    $interval = $startTime->diff($endDate);
    $totalMiliseconds = 0;
    $totalMiliseconds += $interval->m * 2630000000;
    $totalMiliseconds += $interval->d * 86400000;
    $totalMiliseconds += $interval->h * 3600000;
    $totalMiliseconds += $interval->i * 60000;
    $totalMiliseconds += $interval->s * 1000;

    $func = $abs ? 'abs' : 'intval';
    return $totalMiliseconds;
}
?>