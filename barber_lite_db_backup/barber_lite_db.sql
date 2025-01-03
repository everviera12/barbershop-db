PGDMP  6    
            	    |            barber_lite_db    16.2    16.2 /    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    57422    barber_lite_db    DATABASE     �   CREATE DATABASE barber_lite_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE barber_lite_db;
                postgres    false            �            1255    65624    delete_user(integer) 	   PROCEDURE     @  CREATE PROCEDURE public.delete_user(IN _user_id integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM users
    WHERE id = _user_id;

    IF FOUND THEN
        RAISE NOTICE 'User with ID % deleted successfully.', _user_id;
    ELSE
        RAISE NOTICE 'No user found with ID %.', _user_id;
    END IF;
END;
$$;
 8   DROP PROCEDURE public.delete_user(IN _user_id integer);
       public          postgres    false            �            1255    65622   insert_user(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, date, character varying, character varying) 	   PROCEDURE     m  CREATE PROCEDURE public.insert_user(IN _first_name character varying, IN _last_name character varying, IN _email character varying, IN _phone character varying, IN _password character varying, IN _street character varying, IN _neighborhood character varying, IN _city character varying, IN _state character varying, IN _zip character varying, IN _profile_picture character varying, IN _birth_date date, IN _gender character varying, IN _user_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO users (
        first_name,
        last_name,
        email,
        phone,
        password,
        street,
        neighborhood,
        city,
        state,
        zip,
        profile_picture,
        birth_date,
        gender,
        user_name
    ) VALUES (
        _first_name,
        _last_name,
        _email,
        _phone,
        _password,
        _street,
        _neighborhood,
        _city,
        _state,
        _zip,
        _profile_picture,
        _birth_date,
        _gender,
        _user_name
    );
    
    RAISE NOTICE 'User inserted: % %', _first_name, _last_name;
END;
$$;
 �  DROP PROCEDURE public.insert_user(IN _first_name character varying, IN _last_name character varying, IN _email character varying, IN _phone character varying, IN _password character varying, IN _street character varying, IN _neighborhood character varying, IN _city character varying, IN _state character varying, IN _zip character varying, IN _profile_picture character varying, IN _birth_date date, IN _gender character varying, IN _user_name character varying);
       public          postgres    false            �            1255    65630   update_user(integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, date, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.update_user(IN p_id integer, IN p_first_name character varying, IN p_last_name character varying, IN p_email character varying, IN p_phone character varying, IN p_user_name character varying, IN p_password character varying, IN p_street character varying, IN p_neighborhood character varying, IN p_city character varying, IN p_state character varying, IN p_zip character varying, IN p_profile_picture character varying, IN p_birth_date date, IN p_gender character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE users
    SET 
        first_name = p_first_name,
        last_name = p_last_name,
        email = p_email,
        phone = p_phone,
        user_name = p_user_name,
        password = p_password,  -- Actualizando la contraseña
        street = p_street,
        neighborhood = p_neighborhood,
        city = p_city,
        state = p_state,
        zip = p_zip,
        profile_picture = p_profile_picture,
        birth_date = p_birth_date,
        gender = p_gender
    WHERE id = p_id;

    -- Opción: Lanzar un error si no se actualizó ningún registro
    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_id;
    END IF;
END;
$$;
 �  DROP PROCEDURE public.update_user(IN p_id integer, IN p_first_name character varying, IN p_last_name character varying, IN p_email character varying, IN p_phone character varying, IN p_user_name character varying, IN p_password character varying, IN p_street character varying, IN p_neighborhood character varying, IN p_city character varying, IN p_state character varying, IN p_zip character varying, IN p_profile_picture character varying, IN p_birth_date date, IN p_gender character varying);
       public          postgres    false            �            1259    57571    appointments    TABLE     �  CREATE TABLE public.appointments (
    id integer NOT NULL,
    user_id integer,
    barber_id integer,
    specialty_id integer,
    appointment_date timestamp without time zone NOT NULL,
    status character varying(20) DEFAULT 'Agendado'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
     DROP TABLE public.appointments;
       public         heap    postgres    false            �            1259    57570    appointments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.appointments_id_seq;
       public          postgres    false    223            �           0    0    appointments_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;
          public          postgres    false    222            �            1259    57464    barbers    TABLE     G  CREATE TABLE public.barbers (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(15) NOT NULL,
    password character varying(255) NOT NULL,
    experience_years integer NOT NULL,
    street character varying(100) NOT NULL,
    neighborhood character varying(100) NOT NULL,
    municipality character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    zip character varying(10) NOT NULL,
    profile_picture character varying(255) NOT NULL,
    registration_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status boolean DEFAULT true NOT NULL,
    working_hours jsonb NOT NULL,
    CONSTRAINT barbers_zip_check CHECK (((zip)::text ~ '^[0-9]{5}$'::text))
);
    DROP TABLE public.barbers;
       public         heap    postgres    false            �            1259    57463    barbers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.barbers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.barbers_id_seq;
       public          postgres    false    218            �           0    0    barbers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.barbers_id_seq OWNED BY public.barbers.id;
          public          postgres    false    217            �            1259    57510    barbers_specialties    TABLE     o   CREATE TABLE public.barbers_specialties (
    barber_id integer NOT NULL,
    specialty_id integer NOT NULL
);
 '   DROP TABLE public.barbers_specialties;
       public         heap    postgres    false            �            1259    57502    specialties    TABLE     s   CREATE TABLE public.specialties (
    id integer NOT NULL,
    specialties_name character varying(100) NOT NULL
);
    DROP TABLE public.specialties;
       public         heap    postgres    false            �            1259    57501    specialties_id_seq    SEQUENCE     �   CREATE SEQUENCE public.specialties_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.specialties_id_seq;
       public          postgres    false    220            �           0    0    specialties_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.specialties_id_seq OWNED BY public.specialties.id;
          public          postgres    false    219            �            1259    57437    users    TABLE     @  CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(15) NOT NULL,
    password character varying(255) NOT NULL,
    street character varying(100) NOT NULL,
    neighborhood character varying(100) NOT NULL,
    city character varying(100) NOT NULL,
    state character varying(100) NOT NULL,
    zip character varying(10) NOT NULL,
    profile_picture character varying(255) NOT NULL,
    registration_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    birth_date date NOT NULL,
    gender character varying(10) NOT NULL,
    user_name character varying(100) NOT NULL,
    CONSTRAINT users_zip_check CHECK (((zip)::text ~ '^[0-9]{5}$'::text))
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    57436    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    216            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    215            6           2604    57574    appointments id    DEFAULT     r   ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);
 >   ALTER TABLE public.appointments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    223    222    223            2           2604    57467 
   barbers id    DEFAULT     h   ALTER TABLE ONLY public.barbers ALTER COLUMN id SET DEFAULT nextval('public.barbers_id_seq'::regclass);
 9   ALTER TABLE public.barbers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            5           2604    57505    specialties id    DEFAULT     p   ALTER TABLE ONLY public.specialties ALTER COLUMN id SET DEFAULT nextval('public.specialties_id_seq'::regclass);
 =   ALTER TABLE public.specialties ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            0           2604    57440    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    57571    appointments 
   TABLE DATA           ~   COPY public.appointments (id, user_id, barber_id, specialty_id, appointment_date, status, created_at, updated_at) FROM stdin;
    public          postgres    false    223   #L       �          0    57464    barbers 
   TABLE DATA           �   COPY public.barbers (id, first_name, last_name, email, phone, password, experience_years, street, neighborhood, municipality, state, zip, profile_picture, registration_date, status, working_hours) FROM stdin;
    public          postgres    false    218   @L       �          0    57510    barbers_specialties 
   TABLE DATA           F   COPY public.barbers_specialties (barber_id, specialty_id) FROM stdin;
    public          postgres    false    221   pM       �          0    57502    specialties 
   TABLE DATA           ;   COPY public.specialties (id, specialties_name) FROM stdin;
    public          postgres    false    220   �M       �          0    57437    users 
   TABLE DATA           �   COPY public.users (id, first_name, last_name, email, phone, password, street, neighborhood, city, state, zip, profile_picture, registration_date, birth_date, gender, user_name) FROM stdin;
    public          postgres    false    216   �N       �           0    0    appointments_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.appointments_id_seq', 1, true);
          public          postgres    false    222            �           0    0    barbers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.barbers_id_seq', 1, true);
          public          postgres    false    217            �           0    0    specialties_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.specialties_id_seq', 17, true);
          public          postgres    false    219            �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 31, true);
          public          postgres    false    215            M           2606    57579    appointments appointments_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_pkey;
       public            postgres    false    223            C           2606    57476    barbers barbers_email_key 
   CONSTRAINT     U   ALTER TABLE ONLY public.barbers
    ADD CONSTRAINT barbers_email_key UNIQUE (email);
 C   ALTER TABLE ONLY public.barbers DROP CONSTRAINT barbers_email_key;
       public            postgres    false    218            E           2606    57474    barbers barbers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.barbers
    ADD CONSTRAINT barbers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.barbers DROP CONSTRAINT barbers_pkey;
       public            postgres    false    218            K           2606    57514 ,   barbers_specialties barbers_specialties_pkey 
   CONSTRAINT        ALTER TABLE ONLY public.barbers_specialties
    ADD CONSTRAINT barbers_specialties_pkey PRIMARY KEY (barber_id, specialty_id);
 V   ALTER TABLE ONLY public.barbers_specialties DROP CONSTRAINT barbers_specialties_pkey;
       public            postgres    false    221    221            G           2606    57509     specialties specialties_name_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT specialties_name_key UNIQUE (specialties_name);
 J   ALTER TABLE ONLY public.specialties DROP CONSTRAINT specialties_name_key;
       public            postgres    false    220            I           2606    57507    specialties specialties_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.specialties
    ADD CONSTRAINT specialties_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.specialties DROP CONSTRAINT specialties_pkey;
       public            postgres    false    220            =           2606    57448    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    216            ?           2606    57446    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            A           2606    65621    users users_user_name_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_name_key UNIQUE (user_name);
 C   ALTER TABLE ONLY public.users DROP CONSTRAINT users_user_name_key;
       public            postgres    false    216            P           2606    57585 (   appointments appointments_barber_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_barber_id_fkey FOREIGN KEY (barber_id) REFERENCES public.barbers(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_barber_id_fkey;
       public          postgres    false    218    4677    223            Q           2606    57590 +   appointments appointments_specialty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_specialty_id_fkey FOREIGN KEY (specialty_id) REFERENCES public.specialties(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_specialty_id_fkey;
       public          postgres    false    4681    223    220            R           2606    57580 &   appointments appointments_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.appointments DROP CONSTRAINT appointments_user_id_fkey;
       public          postgres    false    216    4671    223            N           2606    57515 6   barbers_specialties barbers_specialties_barber_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.barbers_specialties
    ADD CONSTRAINT barbers_specialties_barber_id_fkey FOREIGN KEY (barber_id) REFERENCES public.barbers(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.barbers_specialties DROP CONSTRAINT barbers_specialties_barber_id_fkey;
       public          postgres    false    221    218    4677            O           2606    57520 9   barbers_specialties barbers_specialties_specialty_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.barbers_specialties
    ADD CONSTRAINT barbers_specialties_specialty_id_fkey FOREIGN KEY (specialty_id) REFERENCES public.specialties(id) ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.barbers_specialties DROP CONSTRAINT barbers_specialties_specialty_id_fkey;
       public          postgres    false    221    4681    220            �      x������ � �      �      x�u��j�0���S�[�%[�%�^����\
e�6��-��/}�:�=����;��
|7�?��D�t���ߡw�j�b)�Z�� P?;�m�r��h�H�y4]�}gzg�����E|�[,�&'�qt�-��
ǐ[������Ђj^#e��h]�0�C!��*&�P�ɥ��Ҹ�\jTJ���{RҒ/]�"eU�떊��)c�Wv퍆��M3�l)]���.�l=ؿ���C���&���&b����g��	�mч��[����w�'I�I{>      �      x�3�4�2�4bc�=... "      �   �   x�m�MN1���)|DZZ`IQװ蒍'q�R�$�(��G���Q%�4lߏ�>�K팑1��)X��=K�X`�6T�n�t��K�M��Y���3�Z����T
2~+�ή�*���eỹ���*Z��m[S�,��nW�S�^��IT���n�a������,ܓFj�P�Ӟ��ۉN'���$�:J4������j��0����т_���s�`o�A�%r5��+ �:f~J      �   B  x����n�H������V�Ÿ��R��p�c h���]�O�mx���Q?B^����d�N��\e��ֿ��l
��
�(<R�R,���W�L��g������k*Q�/����/��ȫ����{����8�J�$;Kwk.|��nC�9�F�{�VoU�;���ĉǂ�3���SQ'X�F��Dt�8���f����"��)��~����eQ(hD#��N�8)�JtOS����ufe	�v��0ͷ]�JŮ1�%����O����eLn�|�u㲂�ȐTSSdE@�a���-V� C��B�0n�,T)��D�Q�z!@�Oc)(��bCX��p���l��ˇ�w%n�Vg.e=[�fwkH�$揋��+���w�RcH氦�3�㋓����̢Уb�
KG1�6��Ď����g[�G�)I)#M2T�DzI�E�@���(1�����64tx�
rQ]Ơ����2X���������4;��x�gK�[�34zn)������`?9��m�b��PqȽ��bZ0�#�HlyI��;���?����VF�$&�ƙ�l�b|f����"ԘE���*&�4��	�,��am^7��7[,���8���A�ڬ�h���I��뗞Y&�a����$�E���N�r ^q�����7K�B&6���Dhfԡ>�PN_�E�g�R��@��\Y&��AY�%�.@L|���dv	�(X�y$������g��fX��Ii�e5�tBR�;/Kǹ5����TܪQ�-������>_Xz��TY=B�X=�`�[�xn��W_N���H��1_�����^������雷�m[��e�ڡ���G*�&�]�Y��㡰�	��С�颥!��i�,��yD��BKJ���37����״[��s�)��x8hS���D����:��)���3K�j�v��t�s��UJ]�b<��%�3�D䲊%]F]�~��� W�.�ټ�������ι�^�3�2���E�����M})3���0���i��E�6Nu>�`�`�����}谘�?H��|N�@u�C@���KDQt�p"���9Q8�ǀ
��0Z��P�N5�4#�/3?�P3r�Ib����͸Ē�s2��$+��kz��mG�nX�{���f�݈!m.�U��NA�|H�zPL���B��OV.����EM�6 ��a$t�����)�^~˳�?��U���~�c�U���;����U%S}�A�k1һ��������;����'����vm�D��� �R$V#IB�	}V+i��U����dB�\@r�aE)+0����q�	��I�����Xra��o	_���bC}t�S;�$I]R��W���Ƕ��;FM�
����SU�wU��H�96�|��QB��_)�@?�C�D�20B2����_2x'{y���8d��~�]D��ɚ9_c�$Ow��4A{Y�S.��v�_�=0)�8�5C#F���Q߾X�&��*�<n�����������N�ڣ_���&S�R�!4��l�7[ٝ���6�/�d����x��>5tًf^��?�z�8I�Z���y���y�@�f#��G+�7���y�P$��G�w�o~��FA`��sk*�#���($4@�����I�am�����0��� X��4�vI�8m}�b�cuىî��d�߆�tl
��<�A�q�#�s�9��Vxo���Ɔ��1�q"N$��pK�O��U2?(V�s����Xw<�**F)��vv%S܊��	����@�]4�#���Fk7{�N��d�ڋ}Gj'���2�x�[Z��w����`����u�Ld���u�� b���g��_�+ӛI777 x~'e     