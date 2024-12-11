document.addEventListener("DOMContentLoaded", function () {
    // 폼 제출 시 유효성 검사
    const insertForm = document.getElementById("insertForm");
    if (insertForm) {
        insertForm.addEventListener("submit", function (event) {
            const title = document.getElementById("titleInput").value.trim();
            const content = document.getElementById("contentInput").value.trim();

            if (title === "") {
                alert("제목을 입력하세요.");
                document.getElementById("titleInput").focus();
                event.preventDefault();
                return;
            }

            if (content === "") {
                alert("내용을 입력하세요.");
                document.getElementById("contentInput").focus();
                event.preventDefault();
                return;
            }

            if (title.length > 100) {
                alert("제목은 100자를 초과할 수 없습니다.");
                document.getElementById("titleInput").focus();
                event.preventDefault();
                return;
            }

            if (content.length > 500) {
                alert("내용은 500자를 초과할 수 없습니다.");
                document.getElementById("contentInput").focus();
                event.preventDefault();
                return;
            }
        });
    }

    // 취소 버튼
    const cancelButton = document.getElementById("cancelButton");
    if (cancelButton) {
        cancelButton.addEventListener("click", function () {
            if (confirm("작성 중인 내용을 취소하시겠습니까?")) {
                location.href = "/board/list";
            }
        });
    }
});
