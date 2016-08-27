var TeacherAPI = {
    id: 0,
    sn: 0,
    name: '',
    ID: 0,
    pw: '',
    sex: false, 
    activeCoordinate: ['',null, null, null],
    uploadedFile:{
        name: '',
        size: 0,
        postfix:'',
        nameNoPostfix:'',
        handle:{
            status:0,
            downloadDir:'',
            previewDir:'',
            playDir:''
        }
    },
    uploadedFileQueue:[],
    cidIsCourseResource:[]
}; 
function delExtension(name) {
    var str = name.substring(0,name.lastIndexOf("."));
    return str;
}
