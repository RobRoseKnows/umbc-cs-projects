-- CMSC 461, Spring 2019
-- Robert Rose
-- robrose2

INSERT INTO barcodes 
    (barcode) 
VALUES
    -- Format for plant barcodes: PL{type}XXX{4:species#}{3:cultivar#}
    ('PLVXXX0001001'), -- Plants Vegetables Species 1
    ('PLVXXX0001002'),
    ('PLVXXX0002001'), -- Species 2
    ('PLVXXX0002002'),
    ('PLVXXX0003001'), -- Species 3
    ('PLVXXX0003002'),
    ('PLVXXX0004001'), -- Species 4
    ('PLVXXX0004002'),
    ('PLVXXX0005001'), -- Species 5
    ('PLVXXX0005002'),
    ('PLVXXX0006001'), -- Species 6
    ('PLVXXX0006002'),    
    ('PLHXXX0007001'), -- Plants Herbs Species 1
    ('PLHXXX0007002'),
    ('PLHXXX0008001'), -- Species 2
    ('PLHXXX0008002'),
    ('PLHXXX0009001'), -- Species 3
    ('PLHXXX0009002'),
    ('PLHXXX0010001'), -- Species 4
    ('PLHXXX0010002'),
    ('PLHXXX0011001'), -- Species 5
    ('PLHXXX0011002'),
    ('PLHXXX0012001'), -- Species 6
    ('PLHXXX0012002'),
    ('PLFXXX0013001'), -- Plants Flowers Species 1
    ('PLFXXX0013002'),
    ('PLFXXX0014001'), -- Species 2
    ('PLFXXX0014002'),
    ('PLFXXX0015001'), -- Species 3
    ('PLFXXX0015002'),
    ('PLFXXX0016001'), -- Species 4
    ('PLFXXX0016002'),
    ('PLFXXX0017001'), -- Species 5
    ('PLFXXX0017002'),
    ('PLFXXX0018001'), -- Species 6
    ('PLFXXX0018002'),
    -- Format for tray barcodes: TRXXXX{7:id#}
    ('TRXXXX0000001'),
    ('TRXXXX0000002'),
    ('TRXXXX0000003'),
    ('TRXXXX0000004'),
    ('TRXXXX0000005'),
    ('TRXXXX0000006'),
    ('TRXXXX0000007'),
    -- Format for pots barcodes: PT{2:height}{2:volume}{7:id#}
    ('PT03010000001'), -- Height 3"
    ('PT03010000002'),
    ('PT03010000003'),
    ('PT03050000004'),
    ('PT03050000005'),
    ('PT03050000006'),
    ('PT03150000007'),
    ('PT03150000008'),
    ('PT03150000009'),
    ('PT65010000010'), -- Height 6.5"
    ('PT65010000011'),
    ('PT65010000012'),
    ('PT65050000013'),
    ('PT65050000014'),
    ('PT65050000015'),
    ('PT65150000016'),
    ('PT65150000017'),
    ('PT65150000018'),
    ('PT07010000019'), -- Height 7"
    ('PT07010000020'),
    ('PT07010000021'),
    ('PT07050000022'),
    ('PT07050000023'),
    ('PT07050000024'),
    ('PT07150000025'),
    ('PT07150000026'),
    ('PT07150000027'),
    ('PT12040000028'), -- Height 12"
    ('PT12040000029'),
    ('PT12040000030'),
    ('PT12050000031'),
    ('PT12050000032'),
    ('PT12050000033'),
    ('PT12150000034'),
    ('PT12150000035'),
    ('PT12150000036'),
    ('PT12250000037'),
    ('PT12250000038'),
    ('PT12250000039'),
    -- Format for weather station barcodes: WSX{3:start of name}X{6:id#}
    ('WSXARTX000001'), -- Artemis
    ('WSXHADX000002'), -- Hades
    ('WSXACHX000003'), -- Achiles
    ('WSXGANX000004'); -- Ganymede 

INSERT INTO plants
    (
        species, cultivar, common_name, 
        plant_type, is_perannual, days_to_germinate, barcode, 
        req_temperature, req_light, req_air_moisture, req_feeding, req_watering
    )
VALUES
    -- Vegetables
    (
        'Capsicum annuum', 'green', 'Green bell pepper',
        'vegetables', FALSE, 10, 'PLVXXX0001001', 
        70.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Capsicum annuum', 'red', 'Red bell pepper',
        'vegetables', FALSE, 10, 'PLVXXX0001002', 
        70.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Allium sativum', 'red', 'Red garlic',
        'vegetables', TRUE, 20, 'PLVXXX0002001', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Allium sativum', 'white', 'White garlic',
        'vegetables', TRUE, 20, 'PLVXXX0002002', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),    
    (
        'Cucurbita pepo', 'pepo', 'Pumpkin',
        'vegetables', FALSE, 50, 'PLVXXX0003001', 
        20.0, 7.0, 1.0, 1.0, 1.0
    ),
    (
        'Cucurbita pepo', 'cylindrica', 'Zucchini',
        'vegetables', FALSE, 50, 'PLVXXX0003002', 
        20.0, 7.0, 1.0, 1.0, 1.0
    ),
    (
        'Beta vulgaris', 'altissima', 'Sugar beet',
        'vegetables', FALSE, 10, 'PLVXXX0004001', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Beta vulgaris', 'conditiva', 'Beetroot',
        'vegetables', FALSE, 10, 'PLVXXX0004002', 
        20.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Brassica oleracea', 'italica', 'Broccoli',
        'vegetables', FALSE, 20, 'PLVXXX0005001', 
        25.0, 8.3, 1.5, 1.5, 2.5
    ),
    (
        'Brassica oleracea', 'botrytis', 'Cauliflower',
        'vegetables', FALSE, 20, 'PLVXXX0005002', 
        25.0, 8.0, 2.0, 2.0, 2.0
    ),
    (
        'Brassica rapa', 'chinensis', 'Bok choy',
        'vegetables', FALSE, 30, 'PLVXXX0006001', 
        23.0, 7.0, 1.5, 2.5, 1.5
    ),
    (
        'Brassica rapa', 'rapa', 'Turnip',
        'vegetables', FALSE, 30, 'PLVXXX0006002', 
        23.0, 7.6, 2.5, 3.0, 3.0
    ),
    -- Herbs
    (
        'Trientalis latifolia', 'white', 'White starflower',
        'herbs', TRUE, 21, 'PLHXXX0007001', 
        40.0, 6.5, 0.5, 1.6, 1.0
    ),
    (
        'Trientalis latifolia', 'pink', 'Pink starflower',
        'herbs', TRUE, 21, 'PLHXXX0007002', 
        40.0, 6.5, 0.5, 1.6, 1.0
    ),
    (
        'Nepeta cataria', 'pink', 'Pink catnip',
        'herbs', TRUE, 14, 'PLHXXX0008001', 
        30.0, 7.5, 1.5, 1.5, 2.5
    ),
    (
        'Nepeta cataria', 'spotted', 'Spotted catnip',
        'herbs', TRUE, 14, 'PLHXXX0008002', 
        30.0, 7.5, 1.5, 1.5, 2.5
    ),    
    (
        'Ocimum basilicum', 'purpureum', 'Dark opal basil',
        'herbs', FALSE, 20, 'PLHXXX0009001', 
        25.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Ocimum basilicum', 'thyrsiflora', 'Cinnamon basil',
        'herbs', TRUE, 20, 'PLHXXX0009002', 
        25.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Origanum vulgare', 'gracile', 'Oregano',
        'herbs', TRUE, 10, 'PLHXXX0010001', 
        30.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Origanum vulgare', 'hirtum', 'Oregano',
        'herbs', TRUE, 10, 'PLHXXX0010002', 
        30.0, 6.0, 1.0, 1.0, 1.0
    ),
    (
        'Mentha × piperita', 'Candymint', 'Peppermint',
        'herbs', TRUE, 20, 'PLHXXX0011001', 
        35.0, 6.3, 4.5, 1.5, 6.0
    ),
    (
        'Mentha × piperita', 'Citrata', 'Lemon mint',
        'herbs', TRUE, 20, 'PLHXXX0011002', 
        35.0, 6.0, 4.0, 2.0, 6.0
    ),
    (
        'Rosmarinus officinalis', 'albus', 'Albus Rosemary',
        'herbs', FALSE, 30, 'PLHXXX0012001', 
        23.0, 6.0, 1.5, 2.5, 1.5
    ),
    (
        'Rosmarinus officinalis', 'irene', 'Irene Rosemary',
        'herbs', FALSE, 30, 'PLHXXX0012002', 
        23.0, 6.0, 2.5, 3.0, 3.0
    ),
    -- Flowers
    (
        'Tulipa × gesneriana', 'yonina', 'Yonina tulip',
        'flowers', TRUE, 14, 'PLFXXX0013001', 
        26.0, 6.0, 1.5, 2.5, 1.5
    ),
    (
        'Tulipa × gesneriana', 'texas flame', 'Texas flame tulip',
        'flowers', TRUE, 14, 'PLFXXX0013002', 
        26.0, 6.0, 1.5, 2.5, 1.5
    ),   
    (
        'Calendula officinalis', 'lemon', 'Lemon marigold',
        'flowers', TRUE, 14, 'PLFXXX0014001', 
        25.0, 6.2, 1.2, 2.5, 1.4
    ),
    (
        'Calendula officinalis', 'alpha', 'Alpha marigold',
        'flowers', TRUE, 14, 'PLFXXX0014002', 
        25.0, 6.2, 1.2, 2.5, 1.4
    ),
    (
        'Ismelia carinata', 'red', 'Red tricolor daisy',
        'flowers', FALSE, 21, 'PLFXXX0015001', 
        30.0, 6.1, 1.2, 2.5, 1.4
    ),
    (
        'Ismelia carinata', 'white', 'White tricolor daisy',
        'flowers', FALSE, 21, 'PLFXXX0015002', 
        30.0, 6.1, 1.2, 2.5, 1.4
    ),
    (
        'Chrysanthemum morifolium', 'yellow', "Yellow florist's daisy",
        'flowers', TRUE, 21, 'PLFXXX0016001', 
        20.0, 6.0, 1.2, 2.5, 1.3
    ),
    (
        'Chrysanthemum morifolium', 'white', "White florist's daisy",
        'flowers', TRUE, 21, 'PLFXXX0016002', 
        20.0, 6.0, 1.2, 2.5, 1.3
    ),
    (
        'Helianthus annuus', 'american giant', 'American Giant sunflower',
        'flowers', FALSE, 28, 'PLFXXX0017001', 
        20.0, 6.0, 1.5, 2.5, 2.0
    ),
    (
        'Helianthus annuus', 'titan', 'Titan sunflower',
        'flowers', FALSE, 28, 'PLFXXX0017002', 
        20.0, 6.0, 1.5, 2.5, 2.0
    ),
    (
        'Hemerocallis lilioasphodelus', 'wayside king royale', "Wauside King Royale daylily",
        'flowers', FALSE, 21, 'PLFXXX0018001', 
        20.0, 7.0, 1.1, 2.5, 1.3
    ),
    (
        'Hemerocallis lilioasphodelus', 'red magic', "Red Magic daylily",
        'flowers', FALSE, 21, 'PLFXXX0018002', 
        20.0, 7.0, 1.1, 2.5, 1.3
    );

INSERT INTO trays
    (id, barcode, position)
VALUES
    (1, 'TRXXXX0000001', POINT( 0,  0)),
    (2, 'TRXXXX0000002', POINT(-1, -1)),
    (3, 'TRXXXX0000003', POINT(-1,  1)),
    (4, 'TRXXXX0000004', POINT(-2, -1)),
    (5, 'TRXXXX0000005', POINT(-2,  1)),
    (6, 'TRXXXX0000006', POINT( 1, -1)),
    (7, 'TRXXXX0000007', POINT( 1,  1));

INSERT INTO pots
    (
        id, barcode, height, volume, on_tray,
        holding_species, holding_cultivar, holding_planting_date, holding_germination_date
    )
VALUES
    (   -- Height 3"
        01, 'PT03010000001', 03, 01, 1,
        'Calendula officinalis', 'alpha', DATE('2019-03-20'), DATE('2019-04-03') 
    ), 
    (
        02, 'PT03010000002', 03, 01, 1,
        'Calendula officinalis', 'alpha', DATE('2019-03-20'), DATE('2019-04-03') 
    ),
    (
        03, 'PT03010000003', 03, 01, 1,
        'Calendula officinalis', 'alpha', DATE('2019-03-20'), DATE('2019-04-04') 
    ),
    (
        04, 'PT03050000004', 03, 05, 1,
        'Calendula officinalis', 'lemon', DATE('2019-03-20'), DATE('2019-04-03') 
    ),
    (
        05, 'PT03050000005', 03, 05, 1,
        'Calendula officinalis', 'lemon', DATE('2019-03-20'), DATE('2019-04-03') 
    ),
    (
        06, 'PT03050000006', 03, 05, 1,
        'Calendula officinalis', 'lemon', DATE('2019-03-20'), DATE('2019-04-04') 
    ),
    (
        07, 'PT03150000007', 03, 15, 2,
        'Ismelia carinata', 'white', DATE('2019-03-20'), DATE('2019-04-10')
    ),
    (
        08, 'PT03150000008', 03, 15, 2,
        'Ismelia carinata', 'red', DATE('2019-03-20'), DATE('2019-04-10') 
    ),
    (
        09, 'PT03150000009', 03, 15, 2,
        'Ismelia carinata', 'red', DATE('2019-03-20'), DATE('2019-04-11') 
    ),
    (   -- Height 6.5"
        10, 'PT65010000010', 6.5, 01, 3,
        'Nepeta cataria', 'spotted', DATE('2019-04-06'), DATE('2019-04-20') 
    ), 
    (
        11, 'PT65010000011', 6.5, 01, 3,
        'Nepeta cataria', 'spotted', DATE('2019-04-06'), DATE('2019-04-20') 
    ),
    (
        12, 'PT65010000012', 6.5, 01, 3,
       'Nepeta cataria', 'pink', DATE('2019-04-06'), DATE('2019-04-20') 
    ),
    (
        13, 'PT65050000013', 6.5, 05, 2,
        'Ismelia carinata', 'red', DATE('2019-04-02'), DATE('2019-04-16') 
    ),
    (
        14, 'PT65050000014', 6.5, 05, 2,
        'Ismelia carinata', 'red', DATE('2019-04-02'), DATE('2019-04-16') 
    ),
    (
        15, 'PT65050000015', 6.5, 05, 2,
         'Ismelia carinata', 'red', DATE('2019-04-02'), DATE('2019-04-16') 
    ),
    (
        16, 'PT65150000016', 6.5, 15, 2,
         'Ismelia carinata', 'white', DATE('2019-04-02'), DATE('2019-04-17') 
    ),
    (
        17, 'PT65150000017', 6.5, 15, 3,
        'Nepeta cataria', 'pink', DATE('2019-04-05'), DATE('2019-04-20') 
    ),
    (
        18, 'PT65150000018', 6.5, 15, 3,
        'Nepeta cataria', 'pink', DATE('2019-04-07'), DATE('2019-04-20') 
    ),
    (   -- Height 7"
        19, 'PT07010000019', 07, 01, NULL,
        NULL, NULL, NULL, NULL
    ), 
    (
        20, 'PT07010000020', 07, 01, NULL,
        NULL, NULL, NULL, NULL  
    ),
    (
        21, 'PT07010000021', 07, 01, NULL,
        NULL, NULL, NULL, NULL
    ),
    (
        22, 'PT07050000022', 07, 05, 4,
        'Mentha × piperita', 'Candymint', DATE('2019-02-01'), DATE('2019-02-20')
    ),
    (
        23, 'PT07050000023', 07, 05, 4,
        'Mentha × piperita', 'Candymint', DATE('2019-02-01'), DATE('2019-02-20')
    ),
    (
        24, 'PT07050000024', 07, 05, 4,
        'Mentha × piperita', 'Citrata', DATE('2019-02-01'), DATE('2019-02-20') 
    ),
    (
        25, 'PT07150000025', 07, 15, 5,
        'Cucurbita pepo', 'cylindrica', DATE('2019-04-01'), NULL
    ),
    (
        26, 'PT07150000026', 07, 15, 5,
        'Cucurbita pepo', 'cylindrica', DATE('2019-04-01'), NULL
    ),
    (
        27, 'PT07150000027', 07, 15, 5,
        'Cucurbita pepo', 'cylindrica', DATE('2019-04-01'), NULL
    ),
    (   -- Height 12"
        28, 'PT12040000028', 12, 04, 7,
        'Brassica rapa', 'chinensis', DATE('2019-04-01'), DATE('2019-05-01')
    ), 
    (
        29, 'PT12040000029', 12, 04, 7,
        'Brassica rapa', 'chinensis', DATE('2019-04-01'), DATE('2019-05-01')
    ),
    (
        30, 'PT12040000030', 12, 04, 7,
        'Brassica rapa', 'chinensis', DATE('2019-04-01'), DATE('2019-05-01')
    ),
    (
        31, 'PT12050000031', 12, 05, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        32, 'PT12050000032', 12, 05, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        33, 'PT12050000033', 12, 05, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        34, 'PT12150000034', 12, 15, 7,
        'Brassica rapa', 'rapa', DATE('2019-05-01'), NULL
    ),
    (
        35, 'PT12150000035', 12, 15, 7,
        'Brassica rapa', 'rapa', DATE('2019-05-01'), NULL
    ),
    (
        36, 'PT12150000036', 12, 15, 7,
        'Brassica rapa', 'rapa', DATE('2019-05-01'), NULL
    ),
    (
        37, 'PT12250000037', 12, 25, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        38, 'PT12250000038', 12, 25, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    ),
    (
        39, 'PT12250000039', 12, 25, 6,
        'Cucurbita pepo', 'pepo', DATE('2019-04-01'), NULL
    );

INSERT INTO weather_station
    (id, position, station_name, barcode)
VALUES
    (1, POINT(0, 0),    'Artemis',  'WSXARTX000001'),
    (2, POINT(1, 1),    'Hades',    'WSXHADX000002'),
    (3, POINT(-1, -1),  'Achiles',  'WSXACHX000003'),
    (4, POINT(-2, -2),  'Ganymede', 'WSXGANX000004');

-- The last 10 weather events for each station.
INSERT INTO weather_event
    (id, ambient_light, air_moisture, curr_pos, curr_time, temperature, station_id)
VALUES
    (01, 2.0, 2.0, POINT(0, 0), '2019-05-01 12:00:00', 69.0, 1),
    (02, 2.0, 2.0, POINT(0, 0), '2019-04-30 12:00:00', 69.0, 1),
    (03, 2.0, 2.0, POINT(0, 0), '2019-04-29 12:00:00', 69.0, 1),
    (04, 2.0, 2.0, POINT(0, 0), '2019-04-28 12:00:00', 69.0, 1),
    (05, 2.0, 2.0, POINT(0, 0), '2019-04-27 12:00:00', 69.0, 1),
    (06, 2.0, 2.0, POINT(0, 0), '2019-04-26 12:00:00', 69.0, 1),
    (07, 2.0, 2.0, POINT(0, 0), '2019-04-25 12:00:00', 69.0, 1),
    (08, 2.0, 2.0, POINT(0, 0), '2019-04-24 12:00:00', 69.0, 1),
    (09, 2.0, 2.0, POINT(0, 0), '2019-04-23 12:00:00', 69.0, 1),
    (10, 2.0, 2.0, POINT(0, 0), '2019-04-22 12:00:00', 69.0, 1),
    (11, 2.5, 2.1, POINT(1, 1), '2019-05-01 12:00:00', 68.5, 2),
    (12, 2.5, 2.1, POINT(1, 1), '2019-04-30 12:00:00', 68.5, 2),
    (13, 2.5, 2.1, POINT(1, 1), '2019-04-29 12:00:00', 68.5, 2),
    (14, 2.5, 2.1, POINT(1, 1), '2019-04-28 12:00:00', 68.5, 2),
    (15, 2.5, 2.1, POINT(1, 1), '2019-04-27 12:00:00', 68.5, 2),
    (16, 2.5, 2.1, POINT(1, 1), '2019-04-26 12:00:00', 68.5, 2),
    (17, 2.5, 2.1, POINT(1, 1), '2019-04-25 12:00:00', 68.5, 2),
    (18, 2.5, 2.1, POINT(1, 1), '2019-04-24 12:00:00', 68.5, 2),
    (19, 2.5, 2.1, POINT(1, 1), '2019-04-23 12:00:00', 68.5, 2),
    (20, 2.5, 2.1, POINT(1, 1), '2019-04-22 12:00:00', 68.5, 2),
    (21, 2.1, 2.0, POINT(-1, -1), '2019-05-01 12:00:00', 69.0, 3),
    (22, 2.1, 2.0, POINT(-1, -1), '2019-04-30 12:00:00', 69.0, 3),
    (23, 2.1, 2.0, POINT(-1, -1), '2019-04-29 12:00:00', 69.0, 3),
    (24, 2.1, 2.0, POINT(-1, -1), '2019-04-28 12:00:00', 69.0, 3),
    (25, 2.1, 2.0, POINT(-1, -1), '2019-04-27 12:00:00', 69.0, 3),
    (26, 2.1, 2.0, POINT(-1, -1), '2019-04-26 12:00:00', 69.0, 3),
    (27, 2.1, 2.0, POINT(-1, -1), '2019-04-25 12:00:00', 69.0, 3),
    (28, 2.1, 2.0, POINT(-1, -1), '2019-04-24 12:00:00', 69.0, 3),
    (29, 2.1, 2.0, POINT(-1, -1), '2019-04-23 12:00:00', 69.0, 3),
    (30, 2.1, 2.0, POINT(-1, -1), '2019-04-22 12:00:00', 69.0, 3),
    (31, 2.0, 2.1, POINT(-2, -2), '2019-05-01 12:00:00', 69.0, 4),
    (32, 2.0, 2.1, POINT(-2, -2), '2019-04-30 12:00:00', 69.0, 4),
    (33, 2.0, 2.1, POINT(-2, -2), '2019-04-29 12:00:00', 69.0, 4),
    (34, 2.0, 2.1, POINT(-2, -2), '2019-04-28 12:00:00', 69.0, 4),
    (35, 2.0, 2.1, POINT(-2, -2), '2019-04-27 12:00:00', 69.0, 4),
    (36, 2.0, 2.1, POINT(-2, -2), '2019-04-26 12:00:00', 69.0, 4),
    (37, 2.0, 2.1, POINT(-2, -2), '2019-04-25 12:00:00', 69.0, 4),
    (38, 2.0, 2.1, POINT(-2, -2), '2019-04-24 12:00:00', 69.0, 4),
    (39, 2.0, 2.1, POINT(-2, -2), '2019-04-23 12:00:00', 69.0, 4),
    (40, 2.0, 2.1, POINT(-2, -2), '2019-04-22 12:00:00', 69.0, 4);

-- The weather events for the activity log.
INSERT INTO weather_event
    (id, ambient_light, air_moisture, curr_pos, curr_time, temperature, station_id)
VALUES
    (41, 2.0, 2.0, POINT(0, 0), '2019-03-20 12:00:00', 66.0, 1),
    (42, 2.0, 2.0, POINT(0, 0), '2019-03-27 12:00:00', 67.0, 1),
    (43, 2.0, 2.0, POINT(0, 0), '2019-04-04 12:00:00', 68.0, 1),
    (44, 2.1, 2.0, POINT(0, 0), '2019-04-11 12:00:00', 68.5, 1),
    (45, 2.0, 2.0, POINT(0, 0), '2019-04-18 12:00:00', 69.0, 1);


INSERT INTO activity_log
    (
        ts, pot_id, food, water, weather_event_id,
        starting_pos, ending_pos, starting_tray, ending_tray
    )
VALUES
    (
        '2019-03-20 12:29:00', 01, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        '2019-03-20 12:31:00', 02, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        '2019-03-20 12:33:00', 03, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        '2019-03-20 12:37:00', 04, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        '2019-03-20 12:40:00', 05, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        '2019-03-20 12:45:00', 06, 7.0, 7.0, 41,
        NULL,           POINT( 0,  0),  NULL,   1
    ),
    (
        '2019-03-27 12:31:00', 01, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-03-27 12:32:00', 02, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-03-27 12:33:00', 03, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-03-27 12:37:00', 04, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-03-27 12:40:00', 05, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-03-27 12:45:00', 06, 7.0, 7.0, 42,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-04 12:31:00', 01, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-04 12:32:00', 02, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-04 12:33:00', 03, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-04 12:37:00', 04, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-04 12:40:00', 05, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-04 12:45:00', 06, 7.0, 7.0, 43,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-11 12:31:00', 01, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-11 12:32:00', 02, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-11 12:33:00', 03, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-11 12:37:00', 04, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-11 12:40:00', 05, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-11 12:45:00', 06, 7.0, 7.0, 44,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-18 12:31:00', 01, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-18 12:32:00', 02, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-18 12:33:00', 03, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-18 12:37:00', 04, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-18 12:40:00', 05, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-18 12:45:00', 06, 7.0, 7.0, 45,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-22 12:31:00', 01, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-22 12:32:00', 02, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-22 12:33:00', 03, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-22 12:37:00', 04, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-22 12:40:00', 05, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-22 12:45:00', 06, 7.0, 7.0, 10,
        POINT( 0,  0),  POINT( 0,  0),  1,      1
    ),
    (
        '2019-04-23 12:31:00', 01, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        '2019-04-23 12:32:00', 02, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        '2019-04-23 12:33:00', 03, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        '2019-04-23 12:37:00', 04, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        '2019-04-23 12:40:00', 05, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        '2019-04-23 12:45:00', 06, 7.0, 7.0, 19,
        POINT( 0,  0),  POINT( 1,  1),  1,      7
    ),
    (
        '2019-04-24 12:31:00', 01, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        '2019-04-24 12:32:00', 02, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        '2019-04-24 12:33:00', 03, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        '2019-04-24 12:37:00', 04, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        '2019-04-24 12:40:00', 05, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    ),
    (
        '2019-04-24 12:45:00', 06, 7.0, 7.0, 08,
        POINT( 1,  1),  POINT( 0,  0),  7,      1
    );