<%
--------------------------------------------------------------------------------
-- Table template
-- This file is part of LoveLetter project.
--------------------------------------------------------------------------------
%>

<dt><a name="<%=tab.name%>"></a><strong><%=tab.name%></strong></dt>
<dd><%=tab.description%>

<%if type(tab.field) == "table" and #tab.field > 0 then%>
<em>Fields</em>
<div style='text-align:left;'>
<table class='variables'>
	<%
	for p = 1, #tab.field do
		local name = tab.field[p];
		local field = tab.field[name];
		%>
		<tr>
			<td class='name'><%=name%></td>
			<td class='datatype'><%=field["datatype"]%></td>
			<td class='description'><%=field["description"]%></td>
		</tr>
	<%end%>
</table></div>
<%end%>

</dd>
