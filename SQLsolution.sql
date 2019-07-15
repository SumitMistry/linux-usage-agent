------
A-1


SELECT cpu_number,host_id, total_mem,
FROM host_info
GROUP BY host_id
ORDER BY total_mem;

-----
A-2

SELECT host_info.id, host_info.hostname, host_info.total_mem, avg(host_info.total_mem - host_usage.memory_free) as Used Mem, (date_trunc('hour', host_usage."timestamp") + date_part('minute',host_usage."timestamp")::int / 5 * interval '5 min') as five_min_interval
FROM	host_info 
	INNER JOIN host_usage ON host_usage.host_id = host_info.id
GROUP BY five_min_interval, id;

---- 

