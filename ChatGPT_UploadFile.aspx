<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChatGPT_UploadFile.aspx.cs" Inherits="ZipProject.ChatGPT_UploadFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
       <style>
        #dropArea {
            border: 2px dashed #ccc;
            width: 300px;
            height: 200px;
            line-height: 200px;
            text-align: center;
            margin: 20px auto;
        }

        #dropArea.highlight {
            border-color: purple;
            background: #eee;
        }

        #fileList {
            margin: 0;
            padding: 0;
            list-style: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="dropArea">
            <%--拖拉檔案到這裡--%>
            <asp:FileUpload ID="fileUpload" runat="server" AllowMultiple="true" />
        </div>
        <asp:Label ID="label" runat="server" Text=""></asp:Label>
        <ul id="fileList"></ul>
        <asp:Button ID="btnUpload" runat="server" Text="上傳" OnClick="btnUpload_Click" />
    </form>
    <script>
        window.onload = function () {
            var dropArea = document.getElementById('dropArea');
            var fileList = document.getElementById('fileList');
            var fileUpload = document.getElementById('<%= fileUpload.ClientID %>');

            // 拖拉事件
            dropArea.addEventListener('dragenter', function (e) {
                e.preventDefault();
                e.stopPropagation();
                dropArea.classList.add('highlight');
            });

            dropArea.addEventListener('dragleave', function (e) {
                e.preventDefault();
                e.stopPropagation();
                dropArea.classList.remove('highlight');
            });

            dropArea.addEventListener('dragover', function (e) {
                e.preventDefault();
                e.stopPropagation();
            });

            dropArea.addEventListener('drop', function (e) {
                e.preventDefault();
                e.stopPropagation();

                // 將拖拉的檔案放入 fileUpload
                fileUpload.files = e.dataTransfer.files;

                // 更新檔案列表
                updateFileList();
            });

            // 檔案列表更新
            function updateFileList() {
                // 清空檔案列表
                while (fileList.firstChild) {
                    fileList.removeChild(fileList.firstChild);
                }

                // 顯示檔案列表
                for (var i = 0; i < fileUpload.files.length; i++) {
                    var li = document.createElement('li');
                    li.innerHTML = fileUpload.files[i].name;
                    fileList.appendChild(li);
                }
            }

            // 上傳檔案
            function uploadFile() {
                // 創建 FormData
                var formData = new FormData();

                // 添加檔案
                for (var i = 0; i < fileUpload.files.length; i++) {
                    formData.append('file', fileUpload.files[i]);
                }

                // 創建 XMLHttpRequest
                var xhr = new XMLHttpRequest();

                // 監聽進度
                xhr.upload.addEventListener('progress', function (e) {
                    if (e.lengthComputable) {
                        var percent = e.loaded / e.total;
                        label.innerHTML = '上傳進度: ' + (percent * 100).toFixed(2) + '%';
                    }
                }, false);

                // 監聽完成
                xhr.addEventListener('load', function (e) {
                    label.innerHTML = '上傳完成';
                }, false);

                // 發送請求
                xhr.open('POST', 'WebForm1.aspx', true);
                xhr.send(formData);
            }

            // 按鈕點擊事件
            btnUpload.addEventListener('click', function (e) {
                uploadFile();
            }, false);
    </script>
</body>
</html>
