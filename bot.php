<?php
if (!file_exists('madeline.php')) {
    copy('https://phar.madelineproto.xyz/madeline.php', 'madeline.php');
}

include 'madeline.php';

$MadelineProto = new \danog\MadelineProto\API('session.madeline');
$MadelineProto->async(true);

$MadelineProto->loop(function () use ($MadelineProto) {
    yield $MadelineProto->start();
    $me = yield $MadelineProto->get_self();
    $MadelineProto->logger($me);
    yield $MadelineProto->messages->sendMessage(['peer' => '@your_username', 'message' => "Hello!"]);
});
