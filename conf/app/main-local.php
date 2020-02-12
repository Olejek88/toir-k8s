<?php
$config = [
    'components' => [
        'test-ctrl' => [
            'class' => 'common\components\TestCtrl',
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            'viewPath' => '@common/mail',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => true,
        ],
        // конфигурация подключения к redis серверу
        'redis' => [
            'class' => 'yii\redis\Connection',
            'hostname' => 'redis',
            'port' => 6379,
            'database' => 1,
        ],
        // используем redis в качестве хранилища сессий
        'session' => [
            'class' => 'yii\redis\Session',
        ],
    ],
    'aliases' => [
        '@bower' => '@vendor/bower-asset',
//        '@bower-asset' => '@vendor/bower',
        '@npm'   => '@vendor/npm-asset',
//        '@npm-asset'   => '@vendor/npm',
    ],
];

// модуль реализующий выбор базы данных для работы приложения
// загружается для выбора и установки базы до начала выполнения приложения
$config['bootstrap'][] = 'selectdb';
$config['modules']['selectdb'] = [
    'class' => 'common\modules\selectdb\Module',
];

$files = scandir('/var/www/toirus-srv/html/common/config/conf.d');
foreach($files as $file) {
    if ($file !== '.' && $file !== '..') {
        $config['components'] = array_merge(
            $config['components'],
            require('/var/www/toirus-srv/html/common/config/conf.d/' . $file)
        );
    }
}

return $config;

