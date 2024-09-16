FROM hub.madelineproto.xyz/danog/madelineproto

WORKDIR /app

COPY . .

CMD ["php", "/app/bot.php"]
