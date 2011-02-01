<%
--------------------------------------------------------------------------------
-- This file is part of LoveLetter project.
--------------------------------------------------------------------------------

if module_doc then
	from = "modules/"..module_doc.name
elseif file_doc then
	from = "files/.."..file_doc.name
else
	from = ""
end
%>

<dt><%=func.private and "local " or ""%><a name="<%=func.name%>"></a><strong><%=func.name%></strong>&nbsp;(<%=llDoclet:tableConcat(func.param, ", ")%>)</dt>
<dd>
<%=func.description or ""%>

<%if type(func.param) == "table" and #func.param > 0 then%>
<h3>Parameters</h3>
<table class='variables'>
	<%for p = 1, #func.param do
		local name = func.param[p];
		local param = func.param[name] or {};
		%>
		<tr>
		</td>
			<td class='name'><%=name%></td>
			<td class='datatype'><%=param["datatype"] or ""%></td>
			<td class='description'><%=param["description"] or ""%></td>
		</tr>
		<%end%>
</table>

<%end%>


<%if type(func.usage) == "string" then%>
<h3>Usage:</h3>
<%=func.usage%>
<%elseif type(func.usage) == "table" then%>
<h3>Usage</h3>
<ul>
	<%for _, usage in ipairs(func.usage) do%>
	<li><%= usage %>
	<%end%>
</ul>
<%end%>

<%if type(func.ret) == "string" then%>
<h3>Return value:</h3>
<%=func.ret%>
<%elseif type(func.ret) == "table" then%>
<h3>Return values:</h3>
<ol>
	<%for _, ret in ipairs(func.ret) do%>
	<li><%= ret %>
	<%end%>
</ol>
<%end%>

<%if type(func.see) == "string" then %>
<h3>See also:</h3>
	<a href="<%=func.see%>"><%=func.see%></a>
<%elseif type(func.see) == "table" and #func.see > 0 then %>
<h3>See also:</h3>
<ul>
	<%for i = 1, #func.see do%>
	<li><a href="<%=luadoc.doclet.LoveLetter.symbol_link(func.see[i], doc, module_doc, file_doc, from)%>">
		<%=func.see[i]%>
	</a>
	<%end%>
</ul>
<%end%>
</dd>
