<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/global.jsp"%>
<!-- 配置文件 -->
<script type="text/javascript"
	src="${staticPath }/static/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript"
	src="${staticPath }/static/ueditor/ueditor.all.js"></script>
<!-- 实例化编辑器 -->
<script type="text/javascript">
	var noticeContentUe = UE.getEditor('noticeContent', {
		autoHeightEnabled : true,
		autoFloatEnabled : true,
		initialFrameHeight : 300,
	});
</script>
<script type="text/javascript">
	$(function() {
		$('#platformNoticeAddForm').form({
			url : '${path}/easylifeOfficial/platformNotice/add',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
					progressClose();
				}
				return isValid;
			},
			success : function(result) {
				progressClose();
				result = $.parseJSON(result);
				if (result.success) {
					//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');
					parent.$.modalDialog.handler.dialog('close');
				} else {
					var form = $('#platformNoticeAddForm');
					parent.$.messager.alert('错误', eval(result.msg), 'error');
				}
			}
		});
	});
</script>
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false"
		style="overflow: scroll; overflow-y: scroll; padding: 3px;">
		<form id="platformNoticeAddForm" method="post">
			<table class="grid">
				<tr>
					<td>标题</td>
					<td><input name="noticeTitle" type="text" style="width: 100%;"
						placeholder="请输入标题" class="easyui-validatebox span2"
						data-options="required:true" value=""></td>
					<td>公告日期</td>
					<td><input name="noticeDate" placeholder="请选择公告日期"
						onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" data-options="required:true" /></td>
					<td>公告状态</td>
					<td><select name="noticeStatus" class="easyui-combobox"
						data-options="width:140,height:25,editable:false,panelHeight:'auto'">
							<option value="0" selected>有效</option>
							<option value="1">无效</option>
					</select></td>
				</tr>
			</table>
			<table class="grid">
				<tr>
					<td>公告内容</td>
					<td>
						<!-- 加载编辑器的容器 --> <textArea id="noticeContent"
							name="noticeContent" style="width: 100%; height: 100%;"></textArea>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>