CREATE VIEW mesh.mess_depends_list
AS SELECT
	depends."on" AS id,
	(SELECT content FROM mesh.mess WHERE id=depends."on") AS content,
	count(*) AS count
FROM
	mesh.mess,
	LATERAL XMLTABLE(('//depends'::text) PASSING (mess.content) COLUMNS
		"on" ltree PATH ('@on'::text),
		title text PATH ('../title'::text)
	) depends
GROUP BY
	depends."on"
ORDER BY
	count(*) DESC
;
