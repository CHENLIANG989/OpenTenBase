-- bit check

-- 创建一个名为 bittmp 的表，其中包含一个长度为 33 的 bit 字段
CREATE TABLE bittmp (a bit(33));

-- 从 'data/bit.data' 文件中拷贝数据到 bittmp 表中
\copy bittmp from 'data/bit.data'

-- 开启顺序扫描
SET enable_seqscan=on;

-- 查询比 '011011000100010111011000110000100' 小的记录数
SELECT count(*) FROM bittmp WHERE a <   '011011000100010111011000110000100';

-- 查询比 '011011000100010111011000110000100' 小等于的记录数
SELECT count(*) FROM bittmp WHERE a <=  '011011000100010111011000110000100';

-- 查询等于 '011011000100010111011000110000100' 的记录数
SELECT count(*) FROM bittmp WHERE a  =  '011011000100010111011000110000100';

-- 查询比 '011011000100010111011000110000100' 大等于的记录数
SELECT count(*) FROM bittmp WHERE a >=  '011011000100010111011000110000100';

-- 查询比 '011011000100010111011000110000100' 大的记录数
SELECT count(*) FROM bittmp WHERE a >   '011011000100010111011000110000100';

-- 在 bittmp 表的 a 字段上创建 GIST 索引
CREATE INDEX bitidx ON bittmp USING GIST ( a );

-- 关闭顺序扫描
SET enable_seqscan=off;

-- 使用索引进行查询，查询比 '011011000100010111011000110000100' 小的记录数
SELECT count(*) FROM bittmp WHERE a <   '011011000100010111011000110000100';

-- 使用索引进行查询，查询比 '011011000100010111011000110000100' 小等于的记录数
SELECT count(*) FROM bittmp WHERE a <=  '011011000100010111011000110000100';

-- 使用索引进行查询，查询等于 '011011000100010111011000110000100' 的记录数
SELECT count(*) FROM bittmp WHERE a  =  '011011000100010111011000110000100';

-- 使用索引进行查询，查询比 '011011000100010111011000110000100' 大等于的记录数
SELECT count(*) FROM bittmp WHERE a >=  '011011000100010111011000110000100';

-- 使用索引进行查询，查询比 '011011000100010111011000110000100' 大的记录数
SELECT count(*) FROM bittmp WHERE a >   '011011000100010111011000110000100';

-- 测试索引只扫描

-- 关闭位图扫描
SET enable_bitmapscan=off;

-- 解释查询计划，选择 a 字段从 bittmp 表中 WHERE 子句中的 a 字段在 '1000000' 和 '1000001' 之间的记录
EXPLAIN (COSTS OFF)
SELECT a FROM bittmp WHERE a BETWEEN '1000000' and '1000001';
