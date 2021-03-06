<%--
  Created by IntelliJ IDEA.
  User: hp
  Date: 2016/12/18
  Time: 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row" style="width: 500px;margin: auto;padding: 10px">
    <div class="col-sm-12">
        <h4 class="text-center">修改会员</h4>
        <form id="updateMember" class="form-horizontal" role="form">
            <input type="hidden" value="${member.id}" name="id">
            <div class="form-group">
                <label for="updateMemberName" class="col-sm-3 control-label">会员名称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="updateMemberName" name="memberName" value="${member.memberName}" placeholder="会员名称...">
                </div>
            </div>
            <div class="form-group">
                <label for="updateNickName" class="col-sm-3 control-label">会员昵称</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="updateNickName" name="nickName" value="${member.nickName}" placeholder="会员昵称...">
                </div>
            </div>
            <div class="form-group">
                <label for="discountChance" class="col-sm-3 control-label">折扣机会</label>
                <div class="col-sm-9">
                    <select class="form-control" id="discountChance" name="chance">
                        <c:if test="${member.chance eq 1}" var="isTure">
                            <option value="1" selected>有</option>
                            <option value="-1">无</option>
                        </c:if>
                        <c:if test="${not isTure}">
                            <option value="1">有</option>
                            <option value="-1" selected>无</option>
                        </c:if>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="updateMemberPhone" class="col-sm-3 control-label">会员手机</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="updateMemberPhone" name="memberPhone" value="${member.memberPhone}" placeholder="会员手机号...">
                </div>
            </div>
            <div class="form-group">
                <label for="updateMemberBirthday" class="col-sm-3 control-label">会员生日</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control" id="updateMemberBirthday" value="${member.memberBirthday}" name="memberBirthday"
                           placeholder="会员生日...">
                </div>
            </div>

            <div class="form-group">
                <label for="updateDescription" class="col-sm-3 control-label">备注</label>
                <div class="col-sm-9">
                    <textarea class="form-control" id="updateDescription" name="description"
                              placeholder="关于该会员的一些说明...">${member.description}</textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-9">
                    <div class="btn-group">
                        <button type="submit" class="btn btn-default">保存</button>
                        <button id="reset" type="reset" class="btn btn-primary">重置</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $('#updateMemberBirthday').datebox({
            width: 320,
            required: true,
            editable: false
        });
        $("#updateMember").validate({
            rules: {
                memberName: {
                    required: true,
                    minlength: 2,
                    maxlength: 10
                },
                nickName: {
                    required: false,
                    minlength: 2,
                    maxlength: 10
                },
                memberPhone: {
                    required: true,
                    phone: true
                }
            },
            messages: {
                memberName: {
                    required: "请输入会员名称",
                    minlength: "请输入至少2个字符",
                    maxlength: "名字请不要超过10个字符"
                },
                nickName: {
                    required: "请输入会员昵称",
                    minlength: "请输入至少2个字符",
                    maxlength: "名字请不要超过10个字符"
                },
                memberPhone: {
                    required: "请输入会员手机"
                }
            },
            errorElement: "em",
            errorPlacement: function (error, element) {
                // Add the `help-block` class to the error element
                error.addClass("help-block");

                // Add `has-feedback` class to the parent div.form-group
                // in order to add icons to inputs
                element.parents(".col-sm-9").addClass("has-feedback");

                if (element.prop("type") === "checkbox") {
                    error.insertAfter(element.parent("label"));
                } else {
                    error.insertAfter(element);
                }

                // Add the span element, if doesn't exists, and apply the icon classes to it.
                if (!element.next("span")[0]) {
                    $("<span class='glyphicon glyphicon-remove form-control-feedback'></span>").insertAfter(element);
                }
            },
            success: function (label, element) {
                // Add the span element, if doesn't exists, and apply the icon classes to it.
                if (!$(element).next("span")[0]) {
                    $("<span class='glyphicon glyphicon-ok form-control-feedback'></span>").insertAfter($(element));
                }
            },
            highlight: function (element, errorClass, validClass) {
                $(element).parents(".col-sm-9").addClass("has-error").removeClass("has-success");
                $(element).next("span").addClass("glyphicon-remove").removeClass("glyphicon-ok");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).parents(".col-sm-9").addClass("has-success").removeClass("has-error");
                $(element).next("span").addClass("glyphicon-ok").removeClass("glyphicon-remove");
            },
            submitHandler: function (form) {
                var o = $.ROOT.serializeObject($(form));
                $.ajax({
                    type: "POST",
                    url: ROOT + "/member/updateMember.do",
                    data: o,
                    success: function (msg) {
                        $("#member_update_frame").panel("close");
                        $("#memberTable").datagrid('reload');
                        $.ROOT.handleActionResult(msg);
                    }
                })
            },
            ignore: "#updateMemberBirthday"
        });
    });
</script>

