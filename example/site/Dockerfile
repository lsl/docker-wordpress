FROM lslio/composer:latest as composer

COPY ./composer.* /app/
RUN composer-install

# Must use plugins (auto enable)
RUN mv /app/wordpress/wp-content/plugins/all-in-one-wp-migration /app/wordpress/wp-content/mu-plugins/all-in-one-wp-migration
RUN mv /app/wordpress/wp-content/plugins/lcache /app/wordpress/wp-content/mu-plugins/lcache

# Final Build
FROM lslio/wordpress:latest

# Used by nginx + wordpress
ENV SERVER_PROTO=https
ENV SERVER_NAME=example.com
ENV SERVER_ALIAS=www.example.com

# Used by Wordpress
ENV DB_NAME='wordpress'
ENV DB_USER='wordpress'
ENV DB_PASSWORD='wordpress'
ENV DB_HOST='mysql'
ENV WP_DEBUG='false'

# Generate your own salts with docker run --rm lslio/wordpress salt
ENV AUTH_KEY='-GM.Sk1gRDV2}D?+`beZ}Cty?v,#rZ|a--z.l?_7HgWMu)&8S(oC~2u.ECGC3+=X'
ENV SECURE_AUTH_KEY='D_ADN1@kx`FWYv6IQ*UnnD!T]pIZT67U+HlX58/p(mSb~&]Gr->@Z%%l8@t-uyZ*'
ENV LOGGED_IN_KEY='k0ap|!f*jL_S_0Ks5C-q9=mGN#BEr7h/m4`3!::5=5 [~:A>+F!qL2*jqlkOy`UB'
ENV NONCE_KEY='`;dYKh+{K=>!;# 8-kt-Km>~1+s97L|-mUd5QC4q%}J}wW`.hIN~{/(={xUb{=Ro'
ENV AUTH_SALT='Vs&/=u3`sG:uw0WDp8%b-Y6~ =_UJ+ Oc47BK##HAxL}8v3D,t_+L2A!=HU|SD`a'
ENV SECURE_AUTH_SALT='?!LQjInJJf+HRBN!1mA7[iyRZICG=!lBW(]fC5|1Q52RzY>3-]Y3q*XBv2h)(Mg2'
ENV LOGGED_IN_SALT='v2y2x%|cHs6v*thfr~MZG~[MNB-`r9Y~X_ ]f-Q9POmXu-3)p.Juo2-QC!hc^$IL'
ENV NONCE_SALT='0zK_Ww(ljs]w?GHm}6as]w^_wP%!3Jc<~,Dt3pxS{`Rg$$9tsM[aRz$DL^KHW+Kp'

COPY --from=composer --chown=www:www /app/wp-content /var/www/wordpress/wp-content

# lcache needs some help
USER www
RUN ln -s /var/www/wordpress/wp-content/mu-plugins/wp-lcache/object-cache.php /var/www/wordpress/wp-content/object-cache.php
USER root
